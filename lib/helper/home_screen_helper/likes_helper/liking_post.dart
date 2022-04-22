import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future likingPost(String songId) async{
  //base url for like api
  String likeUrl = 'https://v2sov.herokuapp.com/api/like/';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('loggedInUserToken');
  String? userId = prefs.getString('loggedInUserId');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'bearer $userToken'
  };

  var request = http.Request('PUT', Uri.parse('$likeUrl$songId'));
  request.body = json.encode({
    "userId": userId
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint(await response.stream.bytesToString());
  }
  else {
    debugPrint(response.reasonPhrase);
  }
}