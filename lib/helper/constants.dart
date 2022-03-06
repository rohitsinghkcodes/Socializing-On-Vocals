import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value.',
  hintStyle: TextStyle(color: Colors.white54),

  // hintStyle: TextStyle(color: Colors.grey),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xFFFFFFFF), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xFFFFFFFF), width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


//Field for upload description

const kUploadFieldDecoration = InputDecoration(
  hintText: 'Add Some Description',
  hintStyle: TextStyle(color: Colors.grey,),

  // hintStyle: TextStyle(color: Colors.grey),
  contentPadding:
  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xFF795282), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xFF795282), width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);