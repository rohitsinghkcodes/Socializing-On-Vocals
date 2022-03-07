import 'package:http/http.dart' as http;
import 'dart:convert';

var userId = '';
var name = '';
var email = '';
var phone = 0;
var audioListPerUser = [];

Future getUserById(String id) async {
  String baseUrl = 'https://socializingonvocls.herokuapp.com/api/user/';
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse(baseUrl + id));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var data = jsonDecode(await response.stream.bytesToString());
    userId = data['_id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    audioListPerUser = data['SongList'];
  } else {
    print(response.reasonPhrase);
  }
}

Future deleteAudioById(String userId, String bearerToken, String id) async {
  String baseUrl = 'https://socializingonvocls.herokuapp.com/api/delete/';
  var headers = {'Authorization': 'bearer ' + bearerToken, 'userid': userId};
  var request = http.Request('DELETE', Uri.parse(baseUrl + id));
  request.body = '''''';
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}


//updating song name through edit button
Future updateSongName(String bearerToken, String id, String newName) async {
  String baseurl = "https://socializingonvocls.herokuapp.com/api/update/";
  var headers = {'Content-Type': 'application/json', 'Authorization': 'bearer ' + bearerToken};
  var request = http.Request('PATCH', Uri.parse(baseurl + id));
  request.body = json.encode({"filename": newName});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
