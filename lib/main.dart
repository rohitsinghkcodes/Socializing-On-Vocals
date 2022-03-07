import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socializing_on_vocals/Navigation/bottom_nav.dart';
import 'package:socializing_on_vocals/provider/theme_provider.dart';
import 'package:socializing_on_vocals/screens/about_us_screen.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/profile_helper/user_profile_audio_player.dart';
import 'package:socializing_on_vocals/screens/profile_screen.dart';
import 'package:socializing_on_vocals/screens/settings_screen.dart';
import 'package:socializing_on_vocals/screens/authentication/sign_up.dart';
import 'package:socializing_on_vocals/screens/splash_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';
import 'package:socializing_on_vocals/screens/authentication/signin_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
  child:  const Sov(),
  )
  );
}
class Sov extends StatelessWidget {
  const Sov({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,provider,child) {
        return MaterialApp(
          title: "SOV",

          // For default light theme
          theme: ThemeData.light(),

        //for dark theme
          darkTheme: ThemeData.dark(),

          themeMode: provider.themeMode,
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
          },
        );
      }
    );
  }
}
