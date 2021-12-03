import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:socializing_on_vocals/screens/signin_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';
import 'package:socializing_on_vocals/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {

  static const String id = 'signup_screen';
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = "";
  String password = "";
  String name = "";
  String phone = "";


  //form Key
  final _formKey = GlobalKey<FormState>();


  final _text = TextEditingController();
  // bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  //Signup Process
  Future<bool> SignUp(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://thetshirtstore.herokuapp.com/api/signup'));

    request.body = json.encode(
        {"name": name, "email": email, "password": password, "phone": phone});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      print("runing api check----------------");
      print(response.reasonPhrase.runtimeType);
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                child: Column(
                  children: [

                    //Name
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        name = value;
                      },
                      decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
                      validator: (value) {
                        return nameCheck(value!);
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    //Phone Number
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        phone = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your phone no'),
                      validator: (value) {
                        return phoneCheck(value!);
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    //Email
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
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    //Password
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        //Do something with the user input.
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                      validator: (value){
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
                color: Colors.redAccent,
                title: 'Register',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      bool newToken = await SignUp(email, password);
                      if (newToken) {
                        // Navigator.pushNamed(context,SignIn.id);
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignIn.id, (route) => false);
                      } else {
                        print("error in registration");
                        Fluttertoast.showToast(
                          msg: "Invalid User Details!\nPlease try again.",
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
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
