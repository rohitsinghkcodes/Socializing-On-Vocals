import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showSpinner = true;

  // Base Url
  final String baseUrl = 'https://socializingonvocls.herokuapp.com/api/user/';

  // User Information - Other fields could also be added.
  String? name;
  String? email;
  String? phoneNo;

  void getUserDetailsByID() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString('loggedInUserId');
      if (userID == null) {
        debugPrint("User Id cannot be null.");
      } else {
        Uri url = Uri.parse(baseUrl + userID);
        http.Client client = http.Client();
        try {
          http.Response response = await http.get(url);
          if (response.statusCode == 200) {
            String data = response.body;
            Map<String, dynamic> jsonData = jsonDecode(data);
            debugPrint("All the fetched data : " + jsonData.toString());
            setState(() {
              name = jsonData['name'];
              email = jsonData['email'];
              phoneNo = jsonData['phone'].toString();
            });
            setState(() {
              showSpinner = false;
            });
          }
        } finally {
          client.close();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    getUserDetailsByID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: mainPurpleTheme,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: (showSpinner == true)
          ? const Center(
        child: SpinKitFoldingCube(
          color: Color(0xFF8603F1),
          size: 50.0,
        ),
      )
          : Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color(0x1E8603F1),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: 30.0, horizontal: 20.0),
            children: <Widget>[
              const CircleAvatar(
                minRadius: 50.0,
                child: Icon(
                  Icons.person,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 20.0,
              ),
              ListTile(
                title: const Text("Name"),
                trailing: Text(name ?? ""),
              ),
              ListTile(
                title: const Text("Email Address"),
                trailing: Text(email ?? ""),
              ),
              ListTile(
                title: const Text("Phone Number"),
                trailing: Text(phoneNo ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}