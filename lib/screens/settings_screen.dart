import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/about_us_screen.dart';
import 'package:socializing_on_vocals/screens/profile_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

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
    prefs.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, WelcomeScreen.id, (route) => false),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // Method for redirecting the user to the profile page
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: mainPurpleTheme,
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Color(0x1E8603F1),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: ListView(
                        children: ListTile.divideTiles(
                          //          <-- ListTile.divideTiles
                            context: context,
                            tiles: [
                              // GestureDetector(
                              //   onTap: gotoProfilePage,
                              //   child: const ListTile(
                              //     title: Text('Profile'),
                              //   ),
                              // ),

                              ListTile(
                                trailing: Switch(
                                  value: isSwitched,
                                  activeColor: mainPurpleTheme,
                                  activeTrackColor: darkTheme,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      changeTheme();
                                    });
                                  },
                                ),
                                title: const Text('Dark Mode'),
                              ),

                              GestureDetector(
                                onTap: () {
                                  logoutUser();
                                },
                                child: const ListTile(
                                  title: Text('Logout'),
                                ),
                              ),
                            ]).toList(),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Color(0x1E8603F1),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: ListView(
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
                                onTap: null,
                                child: const ListTile(
                                  title: Text('Privacy Policy'),
                                ),
                              ),
                              GestureDetector(
                                onTap: null,
                                child: const ListTile(
                                  title: Text('Terms and Conditions'),
                                ),
                              ),

                            ]).toList(),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}