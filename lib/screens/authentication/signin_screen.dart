import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/components/auth_round_button.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';
import 'package:socializing_on_vocals/screens/home_screen.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login_screen';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  late String email ;
  late String password ;

  String singInBaseUrl ='https://v2sov.herokuapp.com/api/signin';

  //text editing controller
  final formTextController1 = TextEditingController();
  final formTextController2 = TextEditingController();

  //form Key
  final _formKey = GlobalKey<FormState>();


  //sign in function
  Future<dynamic> signIn(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      };
    var request = http.Request(
        'POST', Uri.parse(singInBaseUrl));
    request.body = json.encode({
      "email": email.toString(),
      "password": password.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resultResponse = await response.stream.bytesToString();
      Map<String, dynamic> result = await jsonDecode(resultResponse);


      //user id and user token
      var userId = result["user"]["_id"];
      var userToken = result["token"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedInUserToken', userToken);

      return userId;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF0C0513), Color(0xFF170024), Color(0xFF3A254C),],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          //progress indicator color
          progressIndicator: const CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
          ),
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
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Form(
                  key: _formKey,
                  child: Column
                    (
                    children: [
                      TextFormField(
                        controller: formTextController1,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          //Do something with the user input.
                          setState(() {
                            email = value;
                          });
                        },
                        decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                        validator: (value) {
                          return emailCheck(value!);
                        }
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: formTextController2,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            //Do something with the user input.
                            setState(() {
                              password = value;
                            });
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
                const SizedBox(
                  height: 20.0,
                ),
                AuthRoundedButton(
                    color: purpleButton,
                    title: 'Sign In',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          var userId = await signIn(email, password);
                          debugPrint('\n ********userid $userId');
                          if (userId != null) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            //setting shared pref. variable value
                            prefs.setBool("isLoggedIn", true);
                            prefs.setString('loggedInUserId', userId);

                            Navigator.pushNamedAndRemoveUntil(
                                context, HomeScreen.id, (route) => false);
                          } else {
                            //to clear the text form fields
                            formTextController1.clear();
                            formTextController2.clear();

                            //toast message
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
                          debugPrint(e.toString());
                        }
                      }
                    },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
