import 'package:flutter/material.dart';
import 'dart:math';

Color color1 = Colors.yellowAccent;
Color color2 = Colors.blueAccent;
Color color3 = Colors.greenAccent;
Color color4 = Colors.orangeAccent;
Color color5 = Colors.blueGrey;
Color color6 = Colors.redAccent;
Color color7 = Colors.pinkAccent;
Color color8 = Colors.tealAccent;
List<Color> colorBg = [color1,color2,color3,color4,color5,color6,color7,color8];

Random random = Random();


Color returnBgProfile(){
  int c = random.nextInt(colorBg.length);
  return colorBg[c];
}