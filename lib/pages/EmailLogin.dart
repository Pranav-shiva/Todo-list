import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/service/authService.dart';

import 'Home_page.dart';

class EmailLogIn extends StatefulWidget {
  @override
  State<EmailLogIn> createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {
  bool circular = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: kboxdecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: "tag",
                child: Image.asset(
                  "images/todo.png",
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                controller: emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                emailController.clear();
                passwordController.clear();
                setState(() {
                  circular = true;
                });
                try {
                  UserCredential userCredential =
                      await firebaseAuth.signInWithEmailAndPassword(
                          email: email!.trim(), password: password!);
                  authClass.userName = userCredential.user?.email;

                  setState(() {
                    circular = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } catch (e) {
                  final snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  setState(() {
                    circular = false;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.black,
                  ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: circular
                      ? CircularProgressIndicator()
                      : Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  firebaseAuth.sendPasswordResetEmail(
                      email: emailController.text);
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.deepPurpleAccent),
                )),
          ],
        ),
      ),
    );
  }
}
