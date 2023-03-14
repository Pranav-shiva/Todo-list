import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/view_data.dart';

import 'package:todo/service/authService.dart';

class TodoCard extends StatefulWidget {
  final title;
  final imageUrl;
  final bool check;
  final id;
  final document;

  final min;
  TodoCard({
    this.document,
    this.imageUrl,
    this.title = "",
    this.check = false,
    this.id,
    this.min,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  AuthClass authClass = AuthClass();
  int currYear = DateTime.now().year;

  String day = DateTime.now().weekday.toString();
  bool val = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      val = false;
    });
  }

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
                height: 110,
                child: Card(
                  elevation: 5,
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 0),
                        child: Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: val,
                            onChanged: (bool? value) async {
                              setState(() {
                                val = value!;
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return WillPopScope(
                                      onWillPop: () async {
                                        setState(() {
                                          val = false;
                                        });
                                        return true;
                                      },
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Are you Sure. Task is Completed",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.blue),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            val = false;
                                                          });
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              .doc(widget.id)
                                                              .delete()
                                                              .then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        child: Text("Yes")),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            val = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                          ),
                        ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .doc(widget.id)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewData(
                                                    id: widget.id,
                                                    documents: widget.document,
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              " ${widget.min}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
