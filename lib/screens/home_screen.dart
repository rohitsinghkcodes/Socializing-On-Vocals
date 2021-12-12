import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final String baseUrl = "https://socializingonvocls.herokuapp.com/audio/";

  AudioPlayer audioPlayer = AudioPlayer();

  PageController pageController = PageController(initialPage: 0);
  bool isplaying = true;

  bool showSpinner = false;

  List<String> songList = [];
  int playlistSize = 0;

  Icon icon = const Icon(Icons.pause);

  Future fetchPlaylist() async {
    var url = Uri.parse(baseUrl);
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var songIds = jsonDecode(data);

        List<String> list = [];
        for(var id in songIds)
        {
          list.add(id.toString());
        }

        //Setting playlist size i.e. no of songs available currently in db
        //Updating List of Songs
        setState(() {
          songList = list;
          playlistSize = list.length;
          showSpinner = false;
        });

        //Playing 1st audio song in the starting
        String playUrl = baseUrl + songList[0];
        audioPlayer.play(playUrl);

      } else {
        debugPrint(response.reasonPhrase);
      }

    } catch (e) {
      debugPrint(e.toString());
    }
  }



  //Checking if audio is playing and perform task accordingly
  void isplayingCheck() {
    if (isplaying) {
      audioPlayer.pause();
      setState(() {
        icon = const Icon(Icons.play_arrow);
      });
      isplaying = false;
    } else {
      audioPlayer.resume();
      setState(() {
        icon = const Icon(Icons.pause);
      });
      isplaying = true;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    fetchPlaylist();
    setState(() {
      showSpinner = true;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive)
      {
        audioPlayer.pause();
        debugPrint('Paused');
      }
    else if(state == AppLifecycleState.resumed)
      {
        audioPlayer.resume();
        debugPrint('Resumed');
      }

    if(state == AppLifecycleState.paused)
      {
        audioPlayer.stop();
        debugPrint('Stopped');
      }

    if(state == AppLifecycleState.detached)
      {
        audioPlayer.stop();
        debugPrint('Stopped');
      }

  }


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF8603F1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('SOV'),
            GestureDetector(
              onTap: (){
            logoutUser();
              },
              child: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            isplayingCheck();
          },
          child: PageView.builder(

            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: playlistSize,
            onPageChanged: (audioNumber) async {
              debugPrint(audioNumber.toString());
              audioPlayer.stop();
              //Resetting the plause/play option
              isplaying = true;
              setState(() {
                icon = const Icon(Icons.pause);
              });
              String playUrl = baseUrl + songList[audioNumber];     //song specific url
              audioPlayer.play(playUrl);    //for playing song/audio
            },
            itemBuilder: (context, position) {
              return Center(
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF8603F1),
                  child: icon,
                  tooltip: "Play Music",
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
