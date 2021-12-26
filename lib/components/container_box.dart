import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30),),
        color: Color(0xFFDCDCDC),
      ),
      height: 200,

    );
  }
}
