import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/service/authService.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  AuthClass authClass = AuthClass();
  bool wait = false;
  String buttonName = "send";
  int start = 45;
  String? phoneNumber;
  String verficationIdFinal = "";
  String smsCode = '';
  String? OTP;
  bool resendOTP = false;
  OtpFieldController _otpFieldController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: kboxdecoration,
        child: Column(
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
              width: MediaQuery.of(context).size.width - 40,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  phoneNumber = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "PhoneNumber",
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "(+91)",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () async {
                        startTimer();
                        await authClass.verfyPhoneNumber(
                            "+91$phoneNumber"!, context, setData);
                        setState(() {
                          resendOTP = true;
                        });
                      },
                      child: Text(
                        buttonName,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: wait ? Colors.pinkAccent : Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              controller: _otpFieldController,
              otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.white),
              length: 6,
              width: MediaQuery.of(context).size.width - 40,
              fieldWidth: 50,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                setState(() {
                  smsCode = pin;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            resendOTP == false
                ? Container()
                : RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Send OTP again in, ",
                          style: TextStyle(
                              fontSize: 16, color: Colors.yellowAccent),
                        ),
                        TextSpan(
                          text: "00:$start",
                          style:
                              TextStyle(fontSize: 16, color: Colors.pinkAccent),
                        ),
                        TextSpan(
                          text: " sec ",
                          style: TextStyle(
                              fontSize: 16, color: Colors.yellowAccent),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                authClass.signInwithPhoneNumber(
                    verficationIdFinal, smsCode, context);
                _otpFieldController.clear();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.black,
                  ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Lets Go",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          buttonName = "Resend";
          wait = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(verificationId) {
    setState(() {
      verficationIdFinal = verificationId;
    });
  }
}
