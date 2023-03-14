import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/Home_page.dart';
import 'package:todo/pages/onBoard.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:page_transition/page_transition.dart';

int? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstLaunch = false;
  var auth = FirebaseAuth.instance;
  bool isLogin = false;

  @override
  void initState() {
    chrekIflogin();

    // TODO: implement initState
    super.initState();
  }

  chrekIflogin() async {
    print(isViewed);
    await auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: "images/todo.png",
        splashIconSize: 150,
        nextScreen: isViewed != null
            ? (isLogin ? HomePage() : SignupPage())
            : OnBoard(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
      ),
    );
  }
}
