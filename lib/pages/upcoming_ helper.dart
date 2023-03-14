import 'package:flutter/material.dart';
import 'package:todo/service/authService.dart';

class Cards extends StatefulWidget {
  final title;
  final imageUrl;
  final hour;
  final id;

  final min;
  Cards({
    this.imageUrl,
    this.title = "",
    this.id,
    this.hour = "",
    this.min,
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  AuthClass authClass = AuthClass();
  int currYear = DateTime.now().year;

  String day = DateTime.now().weekday.toString();
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 100,
                child: Card(
                  color: Colors.white.withOpacity(0.9),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(widget.imageUrl),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, top: 20),
                          child: Text(
                            " ${widget.min}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
