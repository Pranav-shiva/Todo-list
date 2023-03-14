import 'package:clock_analog/clock_analog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/service/authService.dart';
import 'button.dart';
import 'package:intl/intl.dart';

class AddToDo extends StatefulWidget {
  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  AuthClass authClass = AuthClass();
  String? title, description, type, category;
  Color? colour;
  TimeOfDay time =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));

  String min = DateFormat().add_jm().format(DateTime.now()).toString();

  DateTime _selectedValue =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

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
                        "Add Task",
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DatePicker(
                              DateTime.now(),
                              daysCount: 60,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              dateTextStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  _selectedValue = date;
                                  print(_selectedValue.year);
                                });
                              },
                            ),
                            Center(
                              child: ClockAnalog(
                                initialTime: time,
                                onChanged: (value) {
                                  time = value;
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, left: 5),
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
                                onChanged: (value) {
                                  title = value;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Task Title',
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
                                onChanged: (value) {
                                  description = value;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Description',
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
                                    ontap: () {
                                      setState(() {
                                        category = "Food";
                                      });
                                    },
                                  ),
                                  TaskTitle(
                                    url:
                                        "https://firebasestorage.googleapis.com/"
                                        "v0/b/todolist-a6134.appspot.com/o/category"
                                        "%2Fworkout.png?alt=media&token=d9fbac34-8d2c-4597-89db-11c4c187e665",
                                    text: "Workout",
                                    type: category,
                                    ontap: () {
                                      setState(() {
                                        category = "Workout";
                                      });
                                    },
                                  ),
                                  TaskTitle(
                                    url:
                                        "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com"
                                        "/o/category%2Fwork.png?alt=media&token=c8d23757-0ca1-44a0-8e66-dc666798e952",
                                    text: "Work",
                                    type: category,
                                    ontap: () {
                                      setState(() {
                                        category = "Work";
                                      });
                                    },
                                  ),
                                  TaskTitle(
                                    url:
                                        "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdesgin.png?alt=media&token=4c55127a-6dbc-49c1-b820-a24591d18326",
                                    text: "Design",
                                    type: category,
                                    ontap: () {
                                      setState(() {
                                        category = "Design";
                                      });
                                    },
                                  ),
                                  TaskTitle(
                                    url:
                                        "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Frunning%20(1).png?alt=media&token=f176721a-8b04-46c9-bc9e-499880d687fd",
                                    text: "Run",
                                    type: category,
                                    ontap: () {
                                      setState(() {
                                        category = "Run";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 25),
                          child: GestureDetector(
                            onTap: () async {
                              String userId = "";
                              userId = FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection(userId)
                                  .add({
                                "title": title,
                                "description": description,
                                "category": category,
                                "min": min,
                                "date": _selectedValue.toString(),
                                "dateTime": DateTime.now(),
                                "value": false,
                                "time": time.toString(),
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 70,
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
                                    "Add Todo",
                                    style: kTextTitle,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
