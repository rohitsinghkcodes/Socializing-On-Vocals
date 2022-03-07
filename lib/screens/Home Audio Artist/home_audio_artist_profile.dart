import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/profile_helper/profile_details_handler.dart';
import 'package:socializing_on_vocals/screens/profile_helper/user_profile_audio_player.dart';

class HomeAudioArtistProfile extends StatefulWidget {
  String userId;

   HomeAudioArtistProfile({Key? key,required this.userId}) : super(key: key);

  @override
  State<HomeAudioArtistProfile> createState() => _HomeAudioArtistProfileState(userId);
}

class _HomeAudioArtistProfileState extends State<HomeAudioArtistProfile> {
  bool isLoading = false;

  late String svgCode;
   late String userId;
  _HomeAudioArtistProfileState(this.userId);

  final TextEditingController _controller = TextEditingController();

  Future fetchData() async {
    await getUserById(userId);
    setState(() {
      isLoading = false;
      svgCode = multiavatar(userId);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      svgCode = multiavatar('');
    });
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    setState(() {
      //resetting to empty details
      name = '';
      email = '';
      userId = '';
      audioListPerUser =[];
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,   // for removing back button
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            //prev radius 20
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: mainPurpleTheme,
        toolbarHeight: 140,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF8603F1),
              radius: 53,
              child: SvgPicture.string(svgCode),
            ),
            const SizedBox(width: 22),
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "🎧  ${audioListPerUser.length}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ],
        ),
      ),
      body: (isLoading == true)
          ? const SpinKitFoldingCube(
        color: Color(0xFF8603F1),
        size: 50.0,
      )
          : RefreshIndicator(
        onRefresh: fetchData,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        strokeWidth: 3.5,
        color: mainPurpleTheme,
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: audioListPerUser.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfileAudioPlayer(sIndex: index, username:name, userId:userId),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Center(
                          child: Text(
                            "${audioListPerUser[index]['filename']}",
                            style: const TextStyle(
                                fontSize: 13,
                                height: 1.25,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: purplePlays,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
