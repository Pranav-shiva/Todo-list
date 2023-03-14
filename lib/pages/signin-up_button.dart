import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final image;
  final text;
  final ontap;
  final bool load;
  SignupButton({this.text, this.image, this.ontap, this.load = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: MediaQuery.of(context).size.width - 60,
          height: 60,
          child: Card(
            elevation: 50,
            child: load
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        image,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        text,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
          )),
    );
  }
}
