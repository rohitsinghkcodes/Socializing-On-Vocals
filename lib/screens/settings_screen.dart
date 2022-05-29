import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/profile_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';
import 'app_details_section/about_us_screen.dart';
import 'app_details_section/privacy_policy.dart';
import 'app_details_section/terms_and_conditions.dart';
class Settings extends StatefulWidget {
  static const id = "settings_screen";

  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AudioPlayer audioPlayer = AudioPlayer();

  bool isSwitched = false;

  void changeTheme() {}

  // Method for logging out user from the system
  void logoutUser() async {
    audioPlayer.stop();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black45,
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => mainPurpleTheme)),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => mainPurpleTheme)),
            onPressed: () {
              prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (route) => false);
            },
            // style: ButtonStyle(),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // Method for redirecting the user to the profile_helper page : after logout
  void gotoProfilePage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.get("isLoggedIn") == true) {
        Navigator.pushNamed(context, ProfileScreen.id);
      } else {
        Fluttertoast.showToast(
          msg: "User is not logged in !",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child:  Text('S E T T ',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
              Center(child:  Text('I N G S',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            ],
          ),
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.ac_unit_rounded)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView
                    (
                    children: ListTile.divideTiles(
                        //          <-- ListTile.divideTiles
                        context: context,
                        tiles: [

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AboutUs.id);
                            },
                            child: const ListTile(
                              title: Text('About Us'),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, PrivacyPolicy.id);
                            },
                            child: const ListTile(
                              title: Text('Privacy Policy'),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, TermsAndConditions.id);
                            },
                            child: const ListTile(
                              title: Text('Terms & Conditions'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              logoutUser();
                            },
                            child: const ListTile(
                              title: Text('Log Out'),
                            ),
                          ),
                        ]).toList(),
                  ),
                ),
                const Text('v2.1.1',style: TextStyle(color: Colors.white70),),     //app version
              ],
            ),
          ),
        ),
      ),
    );
  }
}
