import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/screens/profile_helper/profile_details_handler.dart';


class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  late String svgCode;
  late String userId;
  late String userToken;


  final TextEditingController _controller = TextEditingController();


  Future fetchData() async {
    //setting state for user id and token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('loggedInUserId').toString();
      userToken = prefs.getString('loggedInUserToken').toString();
    });
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
      svgCode = multiavatar('ram');
    });
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: mainPurpleTheme,
        toolbarHeight: 140,
        title: Row(
          children: [
            CircleAvatar(
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
                  "🎧  ${songs.length}",
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
          itemCount: songs.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Play the users playlist on new screen
                      // Hints :
                      // 1. Access the songs list via songs variable.
                      // 2. Access the tapped song via index and songs list.

                      //pressed audio index no
                      debugPrint(index.toString());
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
                            "${songs[index]['filename']}",
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Edit"),
                                        content: TextField(
                                          controller: _controller,
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          maxLength: 30,
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            child: const Text(
                                              "Cancel",
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text("Submit"),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              setState(() {
                                                isLoading = true;
                                              });

                                              String bearerToken = userToken;
                                              String id = songs[index]['_id'];
                                              String newName = _controller.text.toString();
                                              await updateSongName(bearerToken, id, newName).then((_) => fetchData());
                                              _controller.clear();

                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );

                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.edit,
                                        color: Color(0xFF6E01DC),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Color(0xFF6E01DC),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete"),
                                        content: Text("Do you want to delete ${songs[index]['filename']} permanently ?"),
                                        actions: <Widget>[
                                          OutlinedButton(
                                            child: const Text(
                                              "No",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text("Yes"),
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              setState(() {
                                                isLoading = true;
                                              });

                                              String bearerToken = userToken;
                                              String id = songs[index]['_id'];
                                              await deleteAudioById(userId, bearerToken, id).then((_) => fetchData());

                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white70,
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
