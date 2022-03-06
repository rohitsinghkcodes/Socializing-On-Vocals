import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/Navigation/bottom_nav.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainPurpleTheme,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset('images/logo.png'),
              height: 180,
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 1500), () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint('user token---${prefs.getString('loggedInUserToken')}');
      debugPrint('user id---${prefs.getString('loggedInUserId')}');

      navigateUser(); //It will redirect  after  1.5 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    debugPrint(status.toString());
    if (status) {
      // Navigation.pushReplacement(context, "/Home");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const BottomNav()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const WelcomeScreen()));
    }
  }
}
