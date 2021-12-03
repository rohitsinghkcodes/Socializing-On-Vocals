import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/components/rounded_button.dart';

import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:socializing_on_vocals/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  String email = "";
  String password = "";

  //form Key
  final _formKey = GlobalKey<FormState>();

  Future<bool> signIn(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTk2NjJkNTUyMjM4NzAwMjI4MDY2OTMiLCJpYXQiOjE2MzcyNDY0OTl9.9gWsbf3cFNso5zs94gTlUiEDPAzoZYvBto3qaYaiggM'
    };
    var request = http.Request(
        'POST', Uri.parse('https://thetshirtstore.herokuapp.com/api/signin'));
    request.body = json.encode({
      "email": email.toString(),
      "password": password.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //var res = await response.stream.bytesToString();
      //var test = await jsonDecode(res);

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8603F1),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Form(
                key: _formKey,
                child: Column
                  (
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        email = value;
                      },
                      decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                      validator: (value) {
                        return emailCheck(value!);
                      }
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          //Do something with the user input.
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password'),
                      validator:(value){
              return passwordCheck(value!);
              },
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                  color: Color(0xFFB43DFA),
                  title: 'Log In',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        bool userToken = await signIn(email, password);
                        print('\nUsertoken $userToken');
                        if (userToken) {
                          // Navigator.pushNamed(context, Success.id);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool("isLoggedIn", true);
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.id, (route) => false);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Invalid email or password !",
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                        email = "";
                        password = "";
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },),
            ],
          ),
        ),
      ),
    );
  }
}
