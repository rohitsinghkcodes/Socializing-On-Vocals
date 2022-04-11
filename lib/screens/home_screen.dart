import 'dart:convert';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/profile_screen.dart';
import 'package:socializing_on_vocals/screens/settings_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';

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
  bool isLiked  = false;
  bool showSpinner = false;
  List<dynamic> songList = [];
  int currentAudioNo = 0;
  late String audioTitle = "hello";
  int playlistSize = 0;
  bool idDetailsLoaded = false;
  Icon icon = const Icon(Icons.mic_rounded);

  AnimateIconController controllerIcon = AnimateIconController();

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

  void toggleIsLiked()
  {
    if (controllerIcon.isStart()) {
  controllerIcon.animateToEnd();
  } else if (controllerIcon.isEnd()) {
  controllerIcon.animateToStart();
  }
  }

  void handleClick(String value) {
    switch (value) {
      case '👤   Profile':
        audioPlayer.pause();
        setState(() {
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, ProfileScreen.id);
        break;
      case '🎙   Upload':
        audioPlayer.pause();
        setState(() {
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, UploadFile.id);
        break;

      case '⚙️   Settings':
        audioPlayer.pause();
        setState(() {
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, Settings.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF050009),
          elevation: 0.0,
          title: const Center(
            child: Text(''),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xFF281640),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'👤   Profile', '🎙   Upload', '⚙️   Settings'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: (showSpinner == true)
            ? const Center(
                child: SpinKitFoldingCube(
                  color: Color(0xFF8603F1),
                  size: 50.0,
                ),
              )
            : GestureDetector(
                onDoubleTap: () {
                  toggleIsLiked();
                  Fluttertoast.showToast(
                      msg: "Just pressed like button",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black45,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
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
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    toggleIsLiked();
                                    Fluttertoast.showToast(
                                        msg: "Just pressed like button",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black45,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  child:
                                  AnimateIcons(
                                    startIcon: Icons.favorite_border_rounded,
                                    endIcon: Icons.favorite_rounded,
                                    controller: controllerIcon,
                                    size: 30.0,
                                    onStartIconPress: () {
                                      // Clicked on Add Icon
                                      return true;
                                    },
                                    onEndIconPress: () {
                                      // Clicked on Close Icon
                                      return true;
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    startIconColor: const Color(0xffff4c92),
                                    endIconColor: const Color(0xffea095f),
                                    clockwise: false,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  '|',
                                  style: TextStyle(
                                      color: Color(0x20fffdfd), fontSize: 30),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: "Just pressed share button",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black45,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  child: const Icon(
                                    Icons.share_rounded,
                                    color: Color(0xff367fb1),
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  '|',
                                  style: TextStyle(
                                      color: Color(0x20fffdfd), fontSize: 30),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: "Just pressed comment button",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black45,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.bubble_middle_bottom,
                                    color: Color(0xff5eb161),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: isPlaying
                                        ? Image.network(
                                            'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/70098/optimized_large_thumb_stage.jpg',
                                            height: 300.0,
                                            width: 300.0,
                                          )
                                        : Stack(
                                            children: [
                                              ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.25),
                                                    BlendMode.dstATop),
                                                child: Image.network(
                                                  'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/70098/optimized_large_thumb_stage.jpg',
                                                  height: 300.0,
                                                  width: 300.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: 300.0,
                                                  width: 300.0,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.play_arrow_rounded,
                                                    size: 120,
                                                    color: Colors.white70,
                                                  )))
                                            ],
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Column(
                                      children: [
                                        Text(
                                          songList[currentAudioNo]['name']
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            audioPlayer.pause();
                                            setState(() {
                                              icon =
                                                  const Icon(Icons.play_arrow);
                                            });
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeAudioArtistProfile(
                                                        userId: songList[
                                                                    currentAudioNo]
                                                                [
                                                                'userid']['_id']
                                                            .toString()),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            songList[currentAudioNo]['userid']
                                                    ['name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
