import 'dart:convert';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:multiavatar/multiavatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/backpress_check.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/home_screen_helper/initializations.dart';
import 'package:socializing_on_vocals/helper/home_screen_helper/likes_helper/like_checker.dart';
import 'package:socializing_on_vocals/helper/home_screen_helper/likes_helper/liking_post.dart';
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
  final String baseUrl = "https://v2sov.herokuapp.com/audio/";


  String? userId;

  void setUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('loggedInUserId');
    });

  }

  void initPlayer() {

    audioPlayer.onDurationChanged.listen(
      (Duration d) {
        setState(() => duration = d);
      },
    );

    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => position = p);
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  Widget slider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        thumbShape: SliderComponentShape.noOverlay, //removing thumb shape
      ),
      child: Slider(
          activeColor: const Color(0xFF573192),
          inactiveColor: Colors.black45,
          value: position.inSeconds.toDouble(),
          min: 0.0,
          max: duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              seekToSecond(value.toInt());
              value = value;
            });
          }),
    );
  }

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
        debugPrint('####printing list\n$list');

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




          //updating list for like 1st time
          likesList = songList[currentAudioNo]['likes'];
          //setting likes count
          audioLikesCount = likesList.length;

          //setting liked icon or disliked icon
          // likingPost(songId);


          //setting song id
          songId = songList[0]['songid'].toString();
        });

       //setting initial like
        isLikeSet();

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
    position = const Duration(seconds: 0);
    initPlayer();
    setUserId();

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

  void toggleIsLiked(String songId) {

    likingPost(songId);

    if (controllerIcon.isStart()) {
      controllerIcon.animateToEnd();
    }
    else if (controllerIcon.isEnd()) {
      controllerIcon.animateToStart();
    }
  }


  //setting like icon liked or not
  void isLikeSet() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        isLiked = likeChecker(prefs.getString('loggedInUserId'),likesList);
        likeSwitch = isLiked;

    });
  }

  void moreOptClickListener(String value) {
    switch (value) {
      case '👤   Profile':
        setState(() {
          audioPlayer.pause();
          isPlaying = false;
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, ProfileScreen.id);
        break;
      case '🎙   Upload':
        setState(() {
          audioPlayer.pause();
          isPlaying = false;
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, UploadFile.id);
        break;

      case '⚙️   Settings':
        setState(() {
          audioPlayer.pause();
          isPlaying = false;
          icon = const Icon(Icons.play_arrow);
        });
        Navigator.pushNamed(context, Settings.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: OnBackPressed,
      child: Container(
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
                onSelected: moreOptClickListener,
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

                    //adds and removes user id in local like list
                    likeSwitch? songList[currentAudioNo]['likes'].remove(userId): songList[currentAudioNo]['likes'].add(userId);

                    //inc-dec like counter in local state

                    setState(() {
                      likeSwitch? audioLikesCount-=1 : audioLikesCount+=1;
                    likeSwitch = likeSwitch?false:true;

                    });
                    toggleIsLiked(songId);

                  },
                  child: RefreshIndicator(
                    onRefresh: fetchPlaylist,
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    strokeWidth: 3.5,
                    backgroundColor: Colors.transparent,
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
                          position = const Duration(seconds: 0);
                          icon = const Icon(Icons.mic_rounded);

                          //updating the current audio number
                          currentAudioNo = audioNumber;

                          //updating the list of liked on page changed
                          likesList = songList[currentAudioNo]['likes'];
                          //updating likes count
                          audioLikesCount = likesList.length;

                          //setting like button
                          isLikeSet();

                          //setting avatar for the new audio
                          svgCode = multiavatar(
                              songList[currentAudioNo]['userid']['_id']);


                          //updating song id
                          songId = songList[currentAudioNo]['songid'].toString();

                        });

                        debugPrint('**************** $songId\n');

                        //song specific url
                        String playUrl =
                            baseUrl + songList[audioNumber]['songid'];


                        //for playing song/audio
                        audioPlayer.play(playUrl);
                      },
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    audioLikesCount.toString(),
                                    style: const TextStyle(
                                        color: Color(0xffff4c92),
                                    ),
                                  ),
                                  AnimateIcons(
                                    startIcon: isLiked ? Icons.favorite_rounded: Icons.favorite_border_rounded,
                                    endIcon: isLiked? Icons.favorite_border_rounded: Icons.favorite_rounded,
                                    controller: controllerIcon,
                                    size: 30.0,
                                    onStartIconPress: () {

                                      //adds and removes user id in local like list
                                      likeSwitch? songList[currentAudioNo]['likes'].remove(userId): songList[currentAudioNo]['likes'].add(userId);


                                      //inc-dec like counter in local state

                                      setState(() {
                                        likeSwitch? audioLikesCount-=1 : audioLikesCount+=1;
                                        likeSwitch = likeSwitch?false:true;

                                      });
                                      toggleIsLiked(songId);

                                      return true;
                                    },
                                    onEndIconPress: () {
                                      // Clicked on Close Icon
                                      likeSwitch? songList[currentAudioNo]['likes'].remove(userId): songList[currentAudioNo]['likes'].add(userId);

                                      //inc-dec like counter in local state

                                      setState(() {
                                        likeSwitch? audioLikesCount-=1 : audioLikesCount+=1;
                                        likeSwitch = likeSwitch?false:true;

                                      });
                                      toggleIsLiked(songId);
                                      return true;
                                    },
                                    duration:
                                        const Duration(milliseconds: 500),
                                    startIconColor: isLiked? const Color(0xffea095f) : const Color(0xffff4c92),
                                    endIconColor: isLiked? const Color(0xffff4c92) : const Color(0xffea095f),
                                    clockwise: isLiked? true : false,
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
                                    GestureDetector(
                                      onTap: () {
                                        isPlayingCheck();
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: isPlaying
                                            ? Image.network(
                                          songList[currentAudioNo]['art'],
                                                height: 300.0,
                                                width: 300.0,
                                              )
                                            : Stack(
                                                children: [
                                                  ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.25),
                                                            BlendMode.dstATop),
                                                    child: Image.network(
                                                      songList[currentAudioNo]['art'],
                                                    height: 300.0,
                                                      width: 300.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 300.0,
                                                      width: 300.0,
                                                      child: Center(
                                                          child: Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        size: 120,
                                                        color: Colors.white70,
                                                      )))
                                                ],
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 35),
                                      child: slider(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: GestureDetector(
                                        onTap: () {
                                          audioPlayer.pause();
                                          setState(() {
                                            icon = const Icon(Icons.play_arrow);
                                          });
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeAudioArtistProfile(
                                                      userId: songList[
                                                                  currentAudioNo]
                                                              ['userid']['_id']
                                                          .toString()),
                                            ),
                                          );
                                        },
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
                                            Text(
                                              songList[currentAudioNo]['userid']
                                                      ['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
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
      ),
    );
  }
}
