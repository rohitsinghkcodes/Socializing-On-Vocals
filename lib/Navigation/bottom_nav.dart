import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:socializing_on_vocals/helper/backpress_check.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:socializing_on_vocals/screens/upload_screen.dart';

class BottomNav extends StatefulWidget {
  static const id = "bottom_nav";

  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currPage = 0;
  final List<Widget> screens = [
     const HomeScreen(),
    const UploadFile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: OnBackPressed,
      child: Scaffold(
        body: screens[currPage],
        bottomNavigationBar: CurvedNavigationBar(
          color: const Color(0xFF8603F1),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: const Color(0xFF8603F1),
          animationDuration: const Duration(milliseconds: 400),
          index: 0,
          height: 55,
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),

          ],
          onTap: (index) {
            setState(() {
              currPage = index;
            });
            debugPrint('Current Index is $index');
          },
        ),
      ),
    );
  }
}