import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Image.asset('images/logo.png'),
                    height: 180,
                  ),
                ),
                const Text('BY SOV',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 1500), () async {
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const WelcomeScreen()));
    }
  }
}
