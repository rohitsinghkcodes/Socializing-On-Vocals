import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/screens/splash_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String baseUrl = "https://socialzingonvocals.herokuapp.com/";

  AudioPlayer audioPlayer = AudioPlayer();
  PageController pageController = PageController(initialPage: 0);
  bool isplaying = true;

  List<String> audioNames = [];
  List<String> audioUrls = [];
  int playlistSize = 0;

  String playingAudioName = "";
  String playingAudioUrl = "";
  Icon icon = Icon(Icons.pause);

  Future fetchPlaylist() async {
    var url = Uri.parse(baseUrl + "audio");
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonConvertedData = jsonDecode(data);
        var playlist = jsonDecode(jsonConvertedData["data"]);
        for (var audio in playlist) {
          audioNames.add(audio["fileName"]);
          audioUrls.add(baseUrl + audio["fileurl"]);
        }
        print(audioNames);
        print(audioUrls);
        setState(() {
          playlistSize = audioNames.length;
        });
      } else {
        print("HTTP request error!");
      }
    } catch (e) {
      print(e);
    }
  }

  //Checking if audio is playing and perform task accordingly
  void IsplayingCheck() {
    if (isplaying) {
      audioPlayer.pause();
      setState(() {
        icon = Icon(Icons.play_arrow);
      });
      isplaying = false;
    } else {
      audioPlayer.resume();
      setState(() {
        icon = Icon(Icons.pause);
      });
      isplaying = true;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlaylist();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //Method for logging out user from the system
  void logoutUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeScreen.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        IsplayingCheck();
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Color(0xFF8603F1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SOV'),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, UploadFile.id);
                    },
                    child: Icon(Icons.drive_folder_upload),
                  ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  logoutUser();
                },
                child: Icon(Icons.exit_to_app),
              ),
                ],
              ),
            ],
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: playlistSize,
          onPageChanged: (audioNumber) async {
            //Resetting the plau/play option
            isplaying = true;
            setState(() {
              icon = Icon(Icons.pause);
            });

            //Extracting Audio Url
            playingAudioName = audioNames[audioNumber];
            playingAudioUrl = audioUrls[audioNumber];
            print(playingAudioName + " " + playingAudioUrl);
            audioPlayer.play(playingAudioUrl);
          },
          itemBuilder: (context, position) {
            return Center(
              child: FloatingActionButton(
                backgroundColor: Color(0xFF8603F1),
                child: icon,
                tooltip: "Play Music",
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
