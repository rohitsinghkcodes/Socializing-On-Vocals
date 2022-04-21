import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socializing_on_vocals/components/auth_round_button.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:socializing_on_vocals/screens/authentication/signin_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';
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

  String singUpBaseUrl = 'https://v2sov.herokuapp.com/api/signup';


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
  Future<bool> signUp(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse(singUpBaseUrl));

    request.body = json.encode(
        {"name": name, "email": email, "password": password, "phone": phone});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
      return true;
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint("running api check----------------");
      debugPrint(response.reasonPhrase.runtimeType.toString());
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
                  child: Column(
                    children: [

                      //Name
                      TextFormField(
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.white),
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
                      const SizedBox(
                        height: 8.0,
                      ),
                      //Phone Number
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
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
                      const SizedBox(
                        height: 8.0,
                      ),
                      //Email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
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
                      const SizedBox(
                        height: 8.0,
                      ),
                      //Password
                      TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
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
                const SizedBox(
                  height: 20.0,
                ),



                AuthRoundedButton(
                  color: redButton,
                  title: 'Sign Up',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        bool newToken = await signUp(email, password);
                        if (newToken) {
                          // Navigator.pushNamed(context,SignIn.id);
                          Navigator.pushNamedAndRemoveUntil(
                              context, SignIn.id, (route) => false);
                        } else {
                          debugPrint("error in registration");
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
