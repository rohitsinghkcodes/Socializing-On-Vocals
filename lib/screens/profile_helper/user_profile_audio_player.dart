import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/helper/home_screen_helper/initializations.dart';
import 'package:socializing_on_vocals/helper/profile_bg_color_random.dart';
import 'package:socializing_on_vocals/screens/profile_helper/profile_details_handler.dart';

class UserProfileAudioPlayer extends StatefulWidget {
  static const String id = 'user_profile_audio';
  int sIndex;
  String username;
  String userId;

   UserProfileAudioPlayer({Key? key, required this.sIndex, required this.username,required this.userId,}) : super(key: key);


  @override
  State<UserProfileAudioPlayer> createState() => _UserProfileAudioPlayerState(sIndex,username,userId);

}

class _UserProfileAudioPlayerState extends State<UserProfileAudioPlayer> with WidgetsBindingObserver {

   int sIndex;
   String username;
   String userId;
  _UserProfileAudioPlayerState(this.sIndex,this.username,this.userId);

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = true;
  bool showSpinner = false;
  PageController pageController = PageController(initialPage: 0);
  int currentAudioNo = 0;

  final String baseUrl = "https://socializingonvocls.herokuapp.com/audio/";

  late String audioTitle = "";
  int playlistSize = audioListPerUser.length;
  bool idDetailsLoaded = false;
  Icon icon = const Icon(Icons.mic_rounded);

  //For profile_helper SVG
  late String svgCode;

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
    String playUrl = baseUrl + audioListPerUser[sIndex]['_id'];
    audioPlayer.play(playUrl);
    setState(() {
      showSpinner = true;
      svgCode = multiavatar(userId, trBackground: true);
    });
    position = const Duration(seconds: 0);
    initPlayer();
  }


  //for jumping to tapped index of audio list directly
   @override
   void didChangeDependencies() {
     WidgetsBinding.instance!.addPostFrameCallback((_) {
       if (pageController.hasClients) {
         pageController.jumpToPage(sIndex);
       }
     });

     super.didChangeDependencies();
   }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioPlayer.stop();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  //checking life cycle of app and working accordingly
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

  //slider
   void initPlayer(){

     audioPlayer.onDurationChanged.listen((Duration d) {
       setState(() => duration = d);
     },);

     audioPlayer.onAudioPositionChanged.listen((Duration  p){
       setState(() => position = p);
     });

   }

   void seekToSecond(int second){
     Duration newDuration = Duration(seconds: second);
     audioPlayer.seek(newDuration);
   }

   Widget slider() {
     return SliderTheme(
       data: SliderTheme.of(context).copyWith(
         trackHeight: 2,
         thumbShape: SliderComponentShape.noOverlay,   //removing thumb shape
       ),
       child: Slider(
           activeColor: const Color(0xFF573192),
           inactiveColor: Colors.black45  ,
           value: position.inSeconds.toDouble(),
           min: 0.0,
           max: duration.inSeconds.toDouble(),
           onChanged: (double value) {
             setState(() {
               seekToSecond(value.toInt());
               value = value;
             });}),
     );
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
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF050009),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            letterSpacing: 1.5,
          ),
          title:Row(

            crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: returnBgProfile(userId),
                      ),
                      child:
                      SvgPicture.string(svgCode),
                      height: 50,
                      width: 50,

                    ),
                  ),

                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(username.toString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                ],
              ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.ac_unit_rounded)),
            ),
          ],
          // title: const Text('SOV'),
        ),
        body: PageView.builder(
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
              currentAudioNo = audioNumber;
            });
            String playUrl = baseUrl + audioListPerUser[audioNumber]['_id'];//song specific url
            audioPlayer.play(playUrl); //for playing song/audio
          },
          itemBuilder: (context, position) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isPlayingCheck();
                        },
                        child: GestureDetector(
                          onTap: () {
                            isPlayingCheck();
                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(30.0),
                            child: isPlaying
                                ? Image.network(
                              // audioListPerUser[currentAudioNo]['art'],
                              'https://i1.sndcdn.com/artworks-000665106439-po9nf2-t500x500.jpg',
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
                                    //TODO: change url
                                    'https://i1.sndcdn.com/artworks-000665106439-po9nf2-t500x500.jpg',
                                    // audioListPerUser[currentAudioNo]['art'],
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
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: slider(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30),
                        child: Text(
                          audioListPerUser[currentAudioNo]['filename']
                              .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
