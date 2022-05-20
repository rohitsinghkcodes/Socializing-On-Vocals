import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:socializing_on_vocals/screens/Home%20Audio%20Artist/home_audio_artist_profile.dart';

Widget commentSheet(dynamic data, BuildContext context, String userId ) {

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(
      onTap: () {},
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.6,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5903A4), Color(0xFF281640)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              for (var i = 0; i < data.length; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        // Display the image in large form.
                        // add navigation to user profile page

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeAudioArtistProfile(
                                    userId: data[i]['userId']
                                        .toString()),
                          ),
                        );

                        debugPrint("Comment Clicked");
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        child:
                        // CircleAvatar(
                        //   radius: 28,
                        //   child: SvgPicture.string(multiavatar(
                        //       data[i]['userId'],
                        //       trBackground: true)),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              // color: returnBgProfile(data[i]['userId']),
                              color: Color(0xFF9D9B9B),
                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                              child: SvgPicture.string(multiavatar(data[i]['userId'], trBackground: true)),
                            ),
                            height: 90,
                            width: 90,

                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data[i]['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(data[i]['msg']),
                  ),
                )
            ],
          ),
        ),
      ),
    ),
  );
}


Widget commentChild(data) {
  return ListView(
    children: [
      for (var i = 0; i < data.length; i++)
        ListTile(
          leading: GestureDetector(
            onTap: () async {
              // Display the image in large form.
              //TODO: add navigation to user profile page
              debugPrint("Comment Clicked");
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child:
              // CircleAvatar(
              //   backgroundColor: Colors.black26,
              //   radius: 28,
              //   child: SvgPicture.string(
              //       multiavatar(data[i]['userId'], trBackground: true)),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  decoration: const BoxDecoration(
                    // color: returnBgProfile(userId),
                    color: Colors.amber,
                  ),
                  child:
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: SvgPicture.string(multiavatar(data[i]['userId'], trBackground: true)),
                  ),
                  height: 90,
                  width: 90,

                ),
              ),
            ),
          ),
          title: Text(
            data[i]['username'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(data[i]['msg']),
        )
    ],
  );
}