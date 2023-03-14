import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/side__navigation_Bar.dart';
import 'package:todo/pages/siginpage.dart';
import 'package:todo/pages/upcoming_%20helper.dart';
import 'package:todo/service/authService.dart';

import 'List.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  @override
  void initState() {
    getDocs();
    super.initState();
  }

  String? ImageURL;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  List<StreamBl> element = [];
  List<Widget> todo = [];
  int j = 0;

  AuthClass authClass = AuthClass();
  DateTime _selectedValue =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
            iconTheme: IconThemeData(color: Colors.black, size: 30),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: Text(
                "Todo List",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  await authClass.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SignInPage()),
                      (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.black87,
                  ),
                ),
              ),
            ]),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: DatePicker(
                          DateTime.now(),
                          daysCount: 60,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.black,
                          selectedTextColor: Colors.white,
                          dateTextStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          onDateChange: (date) {
                            setState(() {
                              _selectedValue = date;
                              k = 0;
                              element.clear();
                              todo.clear();
                            });
                            getDocs();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: todo,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int k = 0;
  Future getDocs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      //var a = querySnapshot.docs[i]["date"];
      if (_selectedValue.toString() ==
          querySnapshot.docs[i]["date"].toString()) {
        element.add(
          StreamBl(
            title: querySnapshot.docs[i]["title"],
            min: querySnapshot.docs[i]["min"],
            description: querySnapshot.docs[i]["description"],
            category: querySnapshot.docs[i]["category"],
            date: querySnapshot.docs[i]["date"],
          ),
        );
        String imageURL = "";
        switch (element.elementAt(k).category) {
          case "Work":
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fwork.png?alt=media&token=c8d23757-0ca1-44a0-8e66-dc666798e952";
            break;
          case "Workout":
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fworkout.png?alt=media&token=d9fbac34-8d2c-4597-89db-11c4c187e665";

            break;
          case "Food":
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdiet.png?alt=media&token=3fee63ab-30ee-439a-88a8-414af1bb3e78";
            break;
          case "Design":
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdesgin.png?alt=media&token=4c55127a-6dbc-49c1-b820-a24591d18326";
            break;
          case "Run":
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Frunning%20(1).png?alt=media&token=f176721a-8b04-46c9-bc9e-499880d687fd";
            break;
        }

        Widget a = Cards(
          title: element.elementAt(k).title,
          hour: element.elementAt(k).hour,
          min: element.elementAt(k).min,
          imageUrl: imageURL,
        );
        setState(() {
          todo.add(a);
        });
        k++;
      }
    }
  }
}

// Padding(
//   padding: const EdgeInsets.only(right: 40.0),

// Padding(
//   padding: const EdgeInsets.only(right: 40.0),
//   child: GestureDetector(
//       onTap: () {
//         // SideNavBar();
//       },
//       child: Icon(Icons.menu)),
// ),
//////////////////////////
/*    StreamBuilder(
                          stream: _stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            }
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    String imageURL = "";

                                    Map<String, dynamic> document =
                                        snapshot.data?.docs[index].data()
                                            as Map<String, dynamic>;

                                    switch (document["category"]) {
                                      case "Work":
                                        imageURL =
                                            "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fwork.png?alt=media&token=c8d23757-0ca1-44a0-8e66-dc666798e952";
                                        break;
                                      case "Workout":
                                        imageURL =
                                            "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fworkout.png?alt=media&token=d9fbac34-8d2c-4597-89db-11c4c187e665";

                                        break;
                                      case "Food":
                                        imageURL =
                                            "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdiet.png?alt=media&token=3fee63ab-30ee-439a-88a8-414af1bb3e78";
                                        break;
                                      case "Design":
                                        imageURL =
                                            "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Fdesgin.png?alt=media&token=4c55127a-6dbc-49c1-b820-a24591d18326";
                                        break;
                                      case "Run":
                                        imageURL =
                                            "https://firebasestorage.googleapis.com/v0/b/todolist-a6134.appspot.com/o/category%2Frunning%20(1).png?alt=media&token=f176721a-8b04-46c9-bc9e-499880d687fd";
                                        break;
                                    }
                                    element.add(
                                      StreamBl(
                                        title: document["title"],
                                        task: document["task"],
                                        min: document["min"],
                                        hour: document["hour"],
                                        description: document["description"],
                                        date: document["date"],
                                        category: document["category"],
                                      ),
                                    );
                                    return Container();
                                  }),
                            );
                          })*/
