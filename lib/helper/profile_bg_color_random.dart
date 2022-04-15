import 'package:flutter/material.dart';
import 'colors.dart';


List<Color> colorBg = [color1,color6,color7,color5,color2,color3,color4,color8];

Color returnBgProfile(String uId){
  return colorBg[uId.codeUnits[uId.length-1]%8];
}