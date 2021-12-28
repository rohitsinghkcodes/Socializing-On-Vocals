import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:socializing_on_vocals/helper/colors.dart';

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
  bool isPlaying = true;
  bool showSpinner = false;
  List<String> songList = [];
  int playlistSize = 0;
  Icon icon = const Icon(Icons.pause);

  //For fetching the Playlist
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
          icon = const Icon(Icons.pause);
        });

        //Playing 1st audio in the starting
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
  void isPlayingCheck() {
    if (isPlaying) {
      audioPlayer.pause();
      setState(() {
        icon = const Icon(Icons.play_arrow);
      });
      isPlaying = false;
    } else {
      audioPlayer.resume();
      setState(() {
        icon = const Icon(Icons.pause);
      });
      isPlaying = true;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: mainPurpleTheme,
        // title: const Text('SOV'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            isPlayingCheck();
          },
          child: RefreshIndicator(
            onRefresh: fetchPlaylist,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            child: PageView.builder(

              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: playlistSize,
              onPageChanged: (audioNumber) async {
                debugPrint(audioNumber.toString());
                audioPlayer.stop();
                //Resetting the pause/play option
                isPlaying = true;
                setState(() {
                  icon = const Icon(Icons.pause);
                });
                String playUrl = baseUrl + songList[audioNumber];     //song specific url
                audioPlayer.play(playUrl);    //for playing song/audio
              },
              itemBuilder: (context, position) {
                return Center(
                  child: FloatingActionButton(
                    backgroundColor: mainPurpleTheme,
                    child: icon,
                    tooltip: "Play Music",
                    onPressed: () {
                      isPlayingCheck();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
