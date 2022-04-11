import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/welcome_screen.dart';

class UiPage extends StatefulWidget {
  static const id = "home_page_screen";
  const UiPage({Key? key}) : super(key: key);

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  void handleClick(String value) {
    switch (value) {
      case 'Profile': Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()));
        break;
      case 'Settings':
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
        // backgroundColor: const Color(0xFF1E0F2F),
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
                return {'Profile', 'Upload', 'Settings'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.favorite_border_rounded,
                    color: Color(0xffff4c92),
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Color(0x20fffdfd), fontSize: 30),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.share_rounded,
                    color: Color(0xff367fb1),
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Color(0x20fffdfd), fontSize: 30),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    CupertinoIcons.bubble_middle_bottom,
                    color: Color(0xff5eb161),
                    size: 30,
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
                      child: Image.network(
                        'https://d2n9ha3hrkss16.cloudfront.net/uploads/stage/stage_image/69929/optimized_large_thumb_stage.jpg',
                        height: 300.0,
                        width: 300.0,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: const [
                          Text(
                            '100 Bars',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Talha Anjum',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
