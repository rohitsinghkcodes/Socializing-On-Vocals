import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socializing_on_vocals/components/rounded_button.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';

class UploadFile extends StatefulWidget {
  static const id = "upload_screen";

  const UploadFile({Key? key}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  List<PlatformFile>? _files;
  //Spinner for loading screen
  bool showSpinner = false;
  //description of the song
  late String description;
  //checking variable for file selected or not
  bool isAnyFileSelected = false;
  //Controller for textformfield
  final _controllerTEC = TextEditingController();
  //form Key
  final _formKey = GlobalKey<FormState>();
  //color
  //Post request url
  String postUrl = "https://socializingonvocls.herokuapp.com/submit";

  //explorer pick or audio file selection
  void _openFileExplorer() async {
    _files = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['mp3'],
    ))!
        .files;


    if (_files!.first.bytes != null || _files!.first.path != null) {
      //This means some file is selected
      setState(() {
        isAnyFileSelected = true;
      });

      // //adding description value
      // description = _files!.first.name;

      debugPrint('File path: ${_files!.first.path}');
    } else {
      debugPrint('Error in file selection');
      // return null;
    }
  }

  //Selected File Size
    fileSize() {
     int sizeInBytes = _files!.first.size;
     double sizeInMb = sizeInBytes / (1024 * 1024);
     debugPrint('filesize---- $sizeInMb MB');
     return sizeInMb;
   }

  //File Uploading
  Future<bool> fileUpload(String desc) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'bearer ${prefs.getString('loggedInUserToken')}'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(postUrl));

    request.files.add(await http.MultipartFile.fromPath(
            'file', _files!.first.path.toString()));

    // description
    request.fields.addAll({'filename': desc.toString(),
      'userid': prefs.getString('loggedInUserId').toString()
    });

    //Adding headers
    request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    var response = await request.send();

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      debugPrint('check1 ${response.reasonPhrase}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child:  Text('U P L ',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
              Center(child:  Text('O A D',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            ],),
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.ac_unit_rounded)),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child:(showSpinner == true)
                  ? const Center(
                child: SpinKitFoldingCube(
                  color: Color(0xFF8603F1),
                  size: 50.0,
                ),
              )
                  :  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(

                        child: Image.asset('images/file4.png',color: Colors.white.withOpacity(0.75), colorBlendMode: BlendMode.modulate,),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _controllerTEC,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    style: const TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                    decoration: kUploadFieldDecoration,
                    onChanged: (value) {
                      description = value;
                    },
                    validator: (value) {
                      return descCheck(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(

                      children: [
                        RoundedButton(
                          color: isAnyFileSelected
                              ? greenButton
                              : purpleButton,
                          title:
                          // isAnyFileSelected ? _files!.first.name : "Select",
                          isAnyFileSelected ? "Selected" : "Select",
                          onPressed: _openFileExplorer,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        RoundedButton(
                          color: mainPurpleTheme,
                          title: "Upload",
                          onPressed: () async {

                            if (!isAnyFileSelected) {
                              Fluttertoast.showToast(
                                  msg: "Please select any audio file!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }

                            if(fileSize() <= 3.0) {
                              if (_formKey.currentState!.validate() &&
                                  _files!.first.path != null) {
                                setState(() {
                                  showSpinner = true;
                                });

                                try {
                                  bool uploadResponse = await fileUpload(description);
                                  if (uploadResponse) {
                                    showDialog<String>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape:  const RoundedRectangleBorder
                                              (borderRadius: BorderRadius.all(Radius.circular(10.0),),),
                                            // backgroundColor: const Color(0xFFDFB5FF),
                                            content: const SizedBox(
                                              height: 25.0,
                                              child: Center(child: Text(
                                                'File Uploaded Successfully',style: TextStyle(
                                                // color: Color(0xFF4B008B),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),),),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'OK');
                                                  setState(() {
                                                    _controllerTEC.clear();
                                                    isAnyFileSelected = false;
                                                  });
                                                },
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                    );
                                  } else {
                                    debugPrint('not uploaded');
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              }
                            }
                            else{
                              Fluttertoast.showToast(
                                msg: "File size too big!\nPlease select file under 3MB",
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          },
                        ),

                      ],

                    ),
                  )
                 ,
                  const SizedBox(
                    height: 30,
                  )
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
