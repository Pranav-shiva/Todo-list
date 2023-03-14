import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/constant.dart';
import 'package:todo/pages/signuppage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: OnBoardingAnimation(
          controller: PageController(initialPage: 1),
          pages: [
            _GetCardsContent(
              title: "Todo",
              image: 'images/1.png',
              cardContent:
                  "It all started with notepads and has now evolved to advanced to-do lists applications.",
            ),
            _GetCardsContent(
              title: "Benefits",
              image: 'images/2.png',
              cardContent:
                  "One of the most important reasons you should use a to do list is that it will help you stay organised. When you write all your tasks in a list, they seem more manageable",
            ),
            _GetCardsContent(
              title: "Easy to Use",
              image: 'images/3.png',
              cardContent:
                  "This app is easy to use just tap on add button to add nwe task , tap on task to view ,edit and delete",
            ),
          ],
          indicatorDotHeight: 7.0,
          indicatorDotWidth: 7.0,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
        ),
      ),
    );
  }
}

class _GetCardsContent extends StatelessWidget {
  final String image, cardContent, title;
  _storeOnBoard() async {
    int isViewed = 0;
    SharedPreferences prefes = await SharedPreferences.getInstance();
    await prefes.setInt('onBoard', isViewed);
  }

  const _GetCardsContent({
    Key? key,
    this.image = '',
    this.cardContent = '',
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  _storeOnBoard();
                  Navigator.push(
                    context,
                    PageTransition(
                      childCurrent: OnBoarding(),
                      type: PageTransitionType.bottomToTopJoined,
                      child: SignupPage(),
                      isIos: false,
                      duration: Duration(milliseconds: 400),
                    ),
                  );
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: Image.asset(image),
              ),
            ),
            Center(
              child: Text(title, style: GoogleFonts.pacifico(fontSize: 50.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cardContent,
                style:
                    GoogleFonts.overpass(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
