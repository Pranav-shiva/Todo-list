import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/EmailSignup.dart';
import 'package:todo/pages/PhoneAuthApage.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/pages/siginpage.dart';
import 'package:todo/pages/signin-up_button.dart';
import 'package:todo/service/authService.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                "Sign Up",
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
                },
              ),
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
                        childCurrent: SignupPage(),
                        type: PageTransitionType.bottomToTopJoined,
                        child: PhoneAuthPage(),
                        isIos: false,
                        duration: Duration(milliseconds: 400),
                      ));
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
                      childCurrent: SignupPage(),
                      type: PageTransitionType.bottomToTopJoined,
                      child: EmailSignUp(),
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
                  Text("If you already have an Account?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            childCurrent: SignupPage(),
                            type: PageTransitionType.bottomToTopJoined,
                            child: SignInPage(),
                            isIos: false,
                            duration: Duration(milliseconds: 400),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "  LogIn",
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
