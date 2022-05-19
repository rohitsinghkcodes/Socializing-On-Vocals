import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//comment section fetcher
Future postComment(String audioId, String? userId, String? msg, String? userName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cmtBaseUrl = 'https://v2sov.herokuapp.com/api/comment/';

  var headers = {'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'bearer ${prefs.getString('loggedInUserToken')}'};

  var request = http.Request('PUT', Uri.parse(cmtBaseUrl + audioId));

  request.body = json.encode({
    "userId": userId,
    "msg": msg,
    "username": userName
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print(data);
      debugPrint('Commented Successfully');
    }
    else {
      debugPrint(response.reasonPhrase);
    }
  } catch(e){
    debugPrint(e.toString());
  }
}