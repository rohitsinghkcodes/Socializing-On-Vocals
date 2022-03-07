import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/helper/colors.dart';

import 'Home Audio Artist/home_audio_artist_profile.dart';

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
  List<dynamic> songList = [];
  int currentAudioNo = 0;
  late String audioTitle = "hello";
  int playlistSize = 0;
  bool idDetailsLoaded = false;
  Icon icon = const Icon(Icons.mic_rounded);

  //For profile_helper SVG
  late String svgCode;

  //For fetching the Playlist
  Future fetchPlaylist() async {
    var url = Uri.parse(baseUrl);
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;

        List<dynamic> list = await jsonDecode(data);

        //Setting playlist size i.e. no of songs available currently in db
        //Updating List of Songs
        setState(() {
          songList = list;
          playlistSize = list.length;
          showSpinner = false;
          idDetailsLoaded = true;
          icon = const Icon(Icons.mic_rounded);
          audioTitle = songList[currentAudioNo]['name'];
          svgCode = multiavatar(songList[currentAudioNo]['userid']['_id']);
        });

        //Playing 1st audio in the starting
        String playUrl = baseUrl + songList[0]["songid"];
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
        icon = const Icon(Icons.mic_rounded);
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

    if (state == AppLifecycleState.inactive) {
      audioPlayer.pause();
      debugPrint('Paused');
    } else if (state == AppLifecycleState.resumed) {
      audioPlayer.resume();
      debugPrint('Resumed');

    }

    if (state == AppLifecycleState.paused) {
      audioPlayer.stop();
      debugPrint('Stopped');
    }

    if (state == AppLifecycleState.detached) {
      audioPlayer.stop();
      debugPrint('Stopped');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: mainPurpleTheme,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          letterSpacing: 1.5,
        ),
        title: idDetailsLoaded == false
            ? Container()
            : GestureDetector(
                //tap to visit profile_helper of artist
                onTap: () {
                  audioPlayer.pause();
                  setState(() {
                    icon = const Icon(Icons.play_arrow);
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeAudioArtistProfile(userId:songList[currentAudioNo]['userid']['_id'].toString()),
                    ),
                  );
                },
                child: Row(
                  children: [
                    // avatar of the artist
                    CircleAvatar(
                      radius: 28,
                      child: SvgPicture.string(svgCode),
                    ),

                    const SizedBox(width: 15),
                    Text(
                      songList[currentAudioNo]['userid']['name']
                          .toString()
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // title: const Text('SOV'),
      ),
      body: (showSpinner == true)
          ? const Center(
              child: SpinKitFoldingCube(
                color: Color(0xFF8603F1),
                size: 50.0,
              ),
            )
          : GestureDetector(
              onTap: () {
                isPlayingCheck();
              },
              child: RefreshIndicator(
                onRefresh: fetchPlaylist,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                strokeWidth: 3.5,
                color: mainPurpleTheme,
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
                      icon = const Icon(Icons.mic_rounded);
                      currentAudioNo = audioNumber;
                      svgCode = multiavatar(
                          songList[currentAudioNo]['userid']['_id']);
                    });
                    String playUrl = baseUrl +
                        songList[audioNumber]['songid']; //song specific url
                    audioPlayer.play(playUrl); //for playing song/audio
                  },
                  itemBuilder: (context, position) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(songList[currentAudioNo]['name']
                            .toString()
                            .toUpperCase()),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: FloatingActionButton(
                            backgroundColor: mainPurpleTheme,
                            child: icon,
                            tooltip: "Play Music",
                            onPressed: () {
                              isPlayingCheck();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
