import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/constant.dart';
import 'button.dart';

class ViewData extends StatefulWidget {
  final Map<String, dynamic> documents;
  final String? id;
  ViewData({required this.documents, this.id});
  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  String? title, description, type, category;
  Color? colour;
  bool edit = false;
  @override
  void initState() {
    type = widget.documents["task"];
    category = widget.documents["category"];
    title = widget.documents["title"] == null
        ? "Let's do it"
        : widget.documents["title"];
    description = widget.documents["description"];
    // TODO: implement initState
    _titleController = TextEditingController(text: title);
    _descriptionController = TextEditingController(text: description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        edit ? "Edit Task" : "View Task",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )),
                ),
              ),
              Expanded(
                flex: 14,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 10.0, left: 25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blueAccent,
                      Colors.cyanAccent,
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  //////////
                  /////////// body part
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16.0, top: 16),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    edit = !edit;
                                  });
                                },
                                child: Icon(
                                  Icons.edit,
                                  color:
                                      edit ? Colors.pinkAccent : Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 5),
                          child: Text(
                            "Task Title",
                            style: kTextTitle,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                            controller: _titleController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              enabled: edit,
                              filled: true,
                              hintText: "title",
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
                        Text(
                          "Description",
                          style: kTextTitle,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                            controller: _descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            enabled: edit,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "description",
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Category",
                          style: kTextTitle,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TaskTitle(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdiet.png?alt=media&token=3fee63ab-30ee-439a-88a8-414af1bb3e78",
                                text: "Food",
                                type: category,
                                ontap: edit
                                    ? () {
                                        setState(() {
                                          category = "Food";
                                        });
                                      }
                                    : null,
                              ),
                              TaskTitle(
                                url: "https://firebasestorage.googleapis.com/"
                                    "v0/b/todolist-a6134.appspot.com/o/category"
                                    "%2Fworkout.png?alt=media&token=d9fbac34-8d2c-4597-89db-11c4c187e665",
                                text: "Workout",
                                type: category,
                                ontap: edit
                                    ? () {
                                        setState(() {
                                          category = "Workout";
                                        });
                                      }
                                    : null,
                              ),
                              TaskTitle(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com"
                                    "/o/category%2Fwork.png?alt=media&token=c8d23757-0ca1-44a0-8e66-dc666798e952",
                                text: "Work",
                                type: category,
                                ontap: edit
                                    ? () {
                                        setState(() {
                                          category = "Work";
                                        });
                                      }
                                    : null,
                              ),
                              TaskTitle(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdesgin.png?alt=media&token=4c55127a-6dbc-49c1-b820-a24591d18326",
                                text: "Design",
                                type: category,
                                ontap: edit
                                    ? () {
                                        setState(() {
                                          category = "Design";
                                        });
                                      }
                                    : null,
                              ),
                              TaskTitle(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Frunning%20(1).png?alt=media&token=f176721a-8b04-46c9-bc9e-499880d687fd",
                                text: "Run",
                                type: category,
                                ontap: edit
                                    ? () {
                                        setState(() {
                                          category = "Run";
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: edit
                              ? GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .doc(widget.id)
                                        .update({
                                      "title": _titleController?.text,
                                      "description":
                                          _descriptionController?.text,
                                      "category": category,
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.white,
                                        Colors.black,
                                      ]),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "Update Todo",
                                          style: kTextTitle,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
