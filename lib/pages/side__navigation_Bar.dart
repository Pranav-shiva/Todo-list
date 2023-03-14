import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/Home_page.dart';
import 'package:todo/pages/profile_Page.dart';
import 'package:todo/pages/upcoming.dart';
import 'package:todo/service/authService.dart';

class SideNavBar extends StatefulWidget {
  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    Name();
    networkImage();
    // TODO: implement initState
    super.initState();
  }

  bool profileImage = false;
  String url = "";

  void networkImage() async {
    var pro = await FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("profile$pro").get();
    setState(() {
      url = querySnapshot.docs[0]["imageURL"];
    });
  }

  String name = "Unknown";

  void Name() async {
    var name1 = await FirebaseAuth.instance.currentUser?.email.toString();
    var name2 = await FirebaseAuth.instance.currentUser?.phoneNumber.toString();
    print(name2);
    if (name2 != null) {
      setState(() {
        name = name2;
      });
    }
    if (name1 != null) {
      setState(() {
        name = name1!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blueAccent,
                  Colors.cyanAccent,
                ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: DrawerHeader(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: HomePage(),
                            type: PageTransitionType.bottomToTopJoined,
                            child: Profile(),
                            isIos: false,
                            duration: Duration(milliseconds: 400),
                          ));
                    },
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: img(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(name),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: ListTile(
                  title: const Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: ListTile(
                  title: const Text('Upcoming',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Upcoming()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ImageProvider? img() {
    if (url == "") {
      return AssetImage("images/profile.jpg");
    }

    return NetworkImage(url);
  }
}
