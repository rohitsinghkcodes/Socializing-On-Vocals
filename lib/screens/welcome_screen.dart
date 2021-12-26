import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/sign_up.dart';
import 'package:socializing_on_vocals/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:socializing_on_vocals/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    //No Firebase App '[DEFAULT]' has been created - (Error Solved)->call Firebase.initializeApp() in Flutter and Firebase

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    //for tween animations
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF180015),
      backgroundColor:  mainPurpleTheme,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 180.0,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'SOCIALIZING ON VOCALS',
                        // textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 27.0,
                          color: Color(0xFFD5A5FF),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            RoundedButton(
              color: purpleButton,
              title: 'Sign In',
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, SignIn.id);
              },
            ),
            RoundedButton(
              color: redButton,
              title: 'SIgn Up',

              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, SignUp.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
