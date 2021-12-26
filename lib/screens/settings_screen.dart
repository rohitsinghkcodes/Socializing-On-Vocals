import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

class Settings extends StatefulWidget {
  static const id = "settings_screen";

  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  AudioPlayer audioPlayer = AudioPlayer();

  //Method for logging out user from the system
  void logoutUser()async{
    audioPlayer.stop();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeScreen.id, (route) => false);
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

        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 12.0),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30),),
              color:Color(0x1E8603F1),
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
              child: ListView(
                children: ListTile.divideTiles( //          <-- ListTile.divideTiles
                    context: context,
                    tiles: [
                      const ListTile(
                        title: Text('Profile'),
                      ),

                      const ListTile(
                        title: Text('About Us'),
                      ),
                      ListTile(
                        trailing: Switch(
                          value: isSwitched,
                          activeColor: mainPurpleTheme,
                          activeTrackColor: darkTheme,
                          onChanged: (value){
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                        title: const Text('Dark Mode'),

                      ),
                      GestureDetector(
                        onTap: (){
                          logoutUser();
                        },
                        child: const ListTile(
                          title: Text('Logout'),
                        ),
                      ),
                    ]
                ).toList(),
              )
            ),
          ),
        ),
      ),
    );
  }
}
