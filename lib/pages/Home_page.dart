import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/TodoCard.dart';
import 'package:todo/pages/side__navigation_Bar.dart';
import 'package:todo/pages/siginpage.dart';
import 'package:todo/pages/view_data.dart';
import 'package:todo/service/authService.dart';
import 'Addtodo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String? ImageURL;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .orderBy('dateTime')
      .snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  @override
  int day = DateTime.now().weekday;
  bool va = false;
  String weekDay() {
    switch (day) {
      case 1:
        return "Monday";
        break;
      case 2:
        return "Tuesday";
        break;
      case 3:
        return "Wednesday";
        break;
      case 4:
        return "Thursday";
        break;
      case 5:
        return "Friday";
        break;
      case 6:
        return "Saturday";
        break;
      case 7:
        return "Sunday";
        break;
    }
    return "";
  }

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
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: FloatingActionButton(
            elevation: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.blueAccent,
              size: 32,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    childCurrent: HomePage(),
                    type: PageTransitionType.bottomToTopJoined,
                    child: AddToDo(),
                    isIos: false,
                    duration: Duration(milliseconds: 400),
                  ));
            },
          ),
        ),
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
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Today's schedule",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        weekDay(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
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

                                  return GestureDetector(
                                    child: TodoCard(
                                      title: document["title"] == null
                                          ? "Let's do it"
                                          : document["title"],
                                      imageUrl: imageURL,
                                      id: snapshot.data?.docs[index].id,
                                      min: document["min"].toString(),
                                      document: document,
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
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
}
// Padding(
//   padding: const EdgeInsets.only(right: 40.0),
//   child: GestureDetector(
//     onTap: () {
//       Navigator.push(
//           context,
//           PageTransition(
//             childCurrent: HomePage(),
//             type: PageTransitionType.bottomToTopJoined,
//             child: Profile(),
//             isIos: false,
//             duration: Duration(milliseconds: 400),
//           ));
//     },
//     child: CircleAvatar(
//       radius: 25,
//       backgroundImage: AssetImage("images/profile.jpg"),
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(right: 40.0),
//   child: GestureDetector(
//       onTap: () {
//         // SideNavBar();
//       },
//       child: Icon(Icons.menu)),
// ),
