// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Material(
          elevation: 5.0,
          color: color,
          borderRadius: BorderRadius.circular(20.0),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 200.0,
            height: 60.0,
            
            child: Text(
              title,
              style: const TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
