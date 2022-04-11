import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/Navigation/bottom_nav.dart';
import 'package:socializing_on_vocals/screens/app_details_section/about_us_screen.dart';
import 'package:socializing_on_vocals/screens/app_details_section/privacy_policy.dart';
import 'package:socializing_on_vocals/screens/app_details_section/terms_and_conditions.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/profile_screen.dart';
import 'package:socializing_on_vocals/screens/settings_screen.dart';
import 'package:socializing_on_vocals/screens/authentication/sign_up.dart';
import 'package:socializing_on_vocals/screens/splash_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/authentication/signin_screen.dart';

void main() {
  runApp(const Sov());
}
class Sov extends StatelessWidget {
  const Sov({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
          title: "SOV",
          // For default light theme
          theme: ThemeData.dark(),
          //Routes
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
            ProfileScreen.id: (context) => const ProfileScreen(),
            AboutUs.id: (context) => const AboutUs(),
            PrivacyPolicy.id: (context) => const PrivacyPolicy(),
            TermsAndConditions.id: (context) => const TermsAndConditions(),
          },
        );

  }
}
