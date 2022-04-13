import 'package:flutter/material.dart';

Color color1 = Colors.yellowAccent;
Color color2 = Colors.blueAccent;
Color color3 = Colors.greenAccent;
Color color4 = Colors.orangeAccent;
Color color5 = Colors.blueGrey;
Color color6 = Colors.redAccent;
Color color8 = Colors.purpleAccent;
Color color7 = Colors.pinkAccent;
List<Color> colorBg = [color1,color6,color7,color8,color2,color3,color4,color5];

Color returnBgProfile(String uId){
  return colorBg[uId.codeUnits[uId.length-1]%8];
}