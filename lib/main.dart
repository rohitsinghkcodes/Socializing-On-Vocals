import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/sign_up.dart';
import 'package:socializing_on_vocals/screens/splash_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/signin_screen.dart';

void main() => runApp(Sov());

class Sov extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SOV",
      theme: ThemeData(
        errorColor: Color(0xFFFF8989),
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(
            color: Color(0xFFFDA5A5),
          ),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        HomeScreen.id: (context) => HomeScreen(),
        UploadFile.id: (context) => UploadFile(),
      },
    );
  }
}
