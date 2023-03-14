import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/EmailLogin.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/pages/signin-up_button.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/service/authService.dart';

import 'PhoneAuthApage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthClass authClass = AuthClass();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: kboxdecoration,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                height: 30,
              ),
              Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              SignupButton(
                  image: "images/google.webp",
                  text: "Continue with Google",
                  load: load,
                  ontap: () async {
                    setState(() {
                      load = true;
                    });
                    await authClass.googleSignIn(context);
                    setState(() {
                      load = false;
                    });
                  }),
              SizedBox(
                height: 15,
              ),
              SignupButton(
                image: "images/phone.png",
                text: "Continue with Phone",
                ontap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      childCurrent: SignInPage(),
                      type: PageTransitionType.bottomToTopJoined,
                      child: PhoneAuthPage(),
                      isIos: false,
                      duration: Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              SignupButton(
                image: "images/emai.png",
                text: "Continue with Email",
                ontap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      childCurrent: SignInPage(),
                      type: PageTransitionType.bottomToTopJoined,
                      child: EmailLogIn(),
                      isIos: false,
                      duration: Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you  don't have Account?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          childCurrent: SignInPage(),
                          type: PageTransitionType.bottomToTopJoined,
                          child: SignupPage(),
                          isIos: false,
                          duration: Duration(milliseconds: 400),
                        ),
                      );
                      (Route<dynamic> route) => false;
                    },
                    child: Text(
                      "  SignUp",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
