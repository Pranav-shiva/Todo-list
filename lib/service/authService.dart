import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/Home_page.dart';

import '../pages/PhoneAuthApage.dart';

class AuthClass {
  final ImagePicker picker = ImagePicker();
  String? userName;
  XFile? image;
  String? imageUrl;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          userName = userCredential.user?.email.toString();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(content: Text("not able to Sign in"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {}
  }

  Future<void> verfyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String? verificationID, [int? ForceResendingtoken]) {
      showSnackBar(context, "verfication code sent on the Phone Number");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verification) {
      showSnackBar(context, "Time Out");
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      userName = userCredential.user?.phoneNumber;

      Navigator.push(
        context,
        PageTransition(
          childCurrent: PhoneAuthPage(),
          type: PageTransitionType.bottomToTopJoined,
          child: HomePage(),
          isIos: false,
          duration: Duration(milliseconds: 400),
        ),
      );
      showSnackBar(context, "loggedIn");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  String UsserId() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return userId;
  }

  void upload() async {
    var pro = await FirebaseAuth.instance.currentUser!.uid;

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("image");
    Reference referenceImageToUpload = referenceDirImages.child(pro);
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      final snapshot =
          await FirebaseFirestore.instance.collection('profile$pro').get();

      if (snapshot.size != 0) {
        await FirebaseFirestore.instance
            .collection("profile$pro")
            .doc()
            .update({
          "imageURL": imageUrl,
        });
      }
      if (snapshot.size == 0) {
        await FirebaseFirestore.instance.collection("profile$pro").add({
          "imageURL": imageUrl,
        });
      }
    } catch (e) {}
  }
}
