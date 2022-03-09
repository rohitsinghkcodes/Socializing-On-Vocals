import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/provider/theme_provider.dart';
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (route) => false);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // Method for redirecting the user to the profile_helper page
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
        toolbarHeight: 60,
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: ListTile.divideTiles(
                      //          <-- ListTile.divideTiles
                      context: context,
                      tiles: [
                        GestureDetector(
                          onTap: () {
                            logoutUser();
                          },
                          child: const ListTile(
                            title: Text('Log Out'),
                          ),
                        ),
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
                        ListTile(
                          trailing: Consumer<ThemeProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton<String>(
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(20),
                              value: provider.currentTheme,
                              items: const [
                                //light dark system
                                DropdownMenuItem<String>(
                                  value: 'light',
                                  child: Text(
                                    'Light',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'dark',
                                  child: Text(
                                    'Dark',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'system',
                                  child: Text(
                                    'System',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                              onChanged: (String? value) {
                                provider.changeTheme(value ?? 'system');
                              },
                            );
                          }),
                          title: const Text('Theme'),
                        ),
                      ]).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
