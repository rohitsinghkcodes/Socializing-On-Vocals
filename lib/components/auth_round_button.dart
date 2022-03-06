// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AuthRoundedButton extends StatelessWidget {
  const AuthRoundedButton({required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white,fontSize: 15),
          ),
        ),
      ),
    );
  }
}
