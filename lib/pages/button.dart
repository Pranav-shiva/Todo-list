import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  final ontap;
  final text;
  final type;
  final String url;
  final double size;
  TaskTitle({this.text, this.ontap, this.type, this.size = 15, this.url = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: url == "" ? 50 : 80,
          width: 120,
          child: Card(
            color: type == text ? Colors.black : Colors.blue,
            elevation: 5,
            child: Stack(
              children: [
                url != ""
                    ? Center(
                        child: Image.network(
                          url,
                        ),
                      )
                    : Container(),
                Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
