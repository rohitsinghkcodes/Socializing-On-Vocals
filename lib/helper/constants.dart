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
  hintText: 'Add a title',
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


//privacy policy and terms and conditions
TextStyle headingStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle content = const TextStyle(fontSize: 14,color: Colors.white70);

//audio art links
const audioArtLinks = [
  'https://i1.sndcdn.com/artworks-000665106439-po9nf2-t500x500.jpg',
  'https://login.lyricallemonade.com/wp-content/uploads/1558328126_9e41973b2ca0da242afc25d97863dda5-620x620.jpg',
  'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/69928/optimized_large_thumb_stage.jpg',
  'https://dw0i2gv3d32l1.cloudfront.net/uploads/stage/stage_image/69927/optimized_large_thumb_stage.jpg',
  'https://dw0i2gv3d32l1.cloudfront.net/uploads/stage/stage_image/67507/optimized_large_thumb_stage.jpg',
  'https://media.istockphoto.com/vectors/young-man-listen-to-music-on-headphones-music-therapy-guy-profile-vector-id1205771672?k=20&m=1205771672&s=170667a&w=0&h=KeWTIsFjySzIFbuQ8y4TcYIUp8Ft2Fpqb0Yy6QxJl2I=',
  'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/71294/optimized_large_thumb_stage.jpg',
];

