import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/Navigation/bottom_nav.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/settings_screen.dart';
import 'package:socializing_on_vocals/screens/sign_up.dart';
import 'package:socializing_on_vocals/screens/splash_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/signin_screen.dart';

void main() => runApp(const Sov());

class Sov extends StatelessWidget {
  const Sov({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SOV",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: const Color(0xFFFF8989),
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(
            color: Color(0xFFFDA5A5),
          ),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignIn.id: (context) => const SignIn(),
        SignUp.id: (context) => const SignUp(),
        HomeScreen.id: (context) =>  const HomeScreen(),
        UploadFile.id: (context) => const UploadFile(),
        BottomNav.id: (context) => const BottomNav(),
        Settings.id: (context) => const Settings(),
      },
    );
  }
}
