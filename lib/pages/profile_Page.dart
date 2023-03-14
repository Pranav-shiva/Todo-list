import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/pages/button.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/service/authService.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    networkImage();
    // TODO: implement initState
    super.initState();
  }

  AuthClass authClass = AuthClass();
  String url = "";

  void networkImage() async {
    var pro = await FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("profile$pro").get();
    setState(() {
      url = querySnapshot.docs[0]["imageURL"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kboxdecoration,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundImage: img(),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TaskTitle(
                  size: 22,
                  text: "Upload",
                  ontap: () {
                    authClass.upload();
                  },
                ),
                IconButton(
                    onPressed: () async {
                      authClass.image = await authClass.picker
                          .pickImage(source: ImageSource.gallery);
                      setState(() {
                        authClass.image = authClass.image;
                      });
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.pinkAccent,
                      size: 50,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  ImageProvider? img() {
    if (url == "") {
      return AssetImage("images/profile.jpg");
    }
    return NetworkImage(url);
  }
}
