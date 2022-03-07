import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
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
      svgCode = multiavatar(userId);
    });
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
        title:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  child: SvgPicture.string(svgCode),
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
      body: GestureDetector(
        onTap: () {
          isPlayingCheck();
        },
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
            });
            String playUrl = baseUrl + audioListPerUser[audioNumber]['_id'];//song specific url
            audioPlayer.play(playUrl); //for playing song/audio
          },
          itemBuilder: (context, position) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(audioListPerUser[currentAudioNo]['filename']
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
    );
  }
}
