import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:socializing_on_vocals/components/rounded_button.dart';
import 'package:socializing_on_vocals/helper/constants.dart';
import 'package:socializing_on_vocals/helper/input_field_conditions.dart';

class UploadFile extends StatefulWidget {
  static final id = "upload_screen";

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  List<PlatformFile>? _files;
  bool showSpinner = false;


  late String description;

  bool isAnyFileSelected = false;

  //Controller for textformfield
  var _controllerTEC = TextEditingController();

  //form Key
  final _formKey = GlobalKey<FormState>();

  //color
  final Color mainThemePurple = Color(0xFF8603F1);

  //explorer pick
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

      //Specific for web and app check
      if (kIsWeb) {
        print('File path: ${_files!.first.bytes}');
        // return _files!.first.bytes;
      } else {
        print('File path: ${_files!.first.path}');
        // return _files!.first.path;
      }
    } else {
      print('Error in file selection');
      // return null;
    }
  }

  //Uploading Uploading
  Future<bool> fileUpload(String desc) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://socialzingonvocals.herokuapp.com/submit'));

    // var filePath = _openFileExplorer();
    // if(filePath == null)
    //   {
    //     print('Error in file selection'); //checking purpose only
    //   }
    print('Check101:: ${_files!.first.path.toString()}');
    request.files
        // .add(await http.MultipartFile.fromPath('file', _files!.first.path.toString()));
        .add(await http.MultipartFile.fromPath(
            'file', _files!.first.path.toString()));

    // description
    request.fields.addAll({'filename': desc.toString()});

    //Adding headers
    request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    var response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // print('uploaded');
      return true;
    } else {
      print(response.statusCode);
      print('check1 ${response.reasonPhrase}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: mainThemePurple,
        centerTitle: true,
        title: Text('File Upload'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _controllerTEC,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: kUploadFieldDecoration,
                    onChanged: (value) {
                      description = value;
                    },
                    validator: (value){
                      return descCheck(value!);
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  RoundedButton(
                    color: isAnyFileSelected?Color(0xFF00B30F):Color(0xFFB43DFA),
                    title: isAnyFileSelected?_files!.first.name:"Select file",
                    onPressed: _openFileExplorer,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  RoundedButton(
                    color: mainThemePurple,
                    title: "Upload",
                    onPressed: () async {

                      if(!isAnyFileSelected)
                        {
                          Fluttertoast.showToast(
                              msg: "Please select any audio file!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }

                      if (_formKey.currentState!.validate() && _files!.first.path != null) {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          bool uploadResponse = await fileUpload(description);
                          if (uploadResponse) {

                            showDialog<String>(

                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Color(0xFFAAFDAA),
                                content: const Text('File Uploaded Successfully'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context, 'OK');
                                      setState(() {
                                        _controllerTEC.clear();
                                        isAnyFileSelected = false;
                                      });
                                    },
                                    child: const Text('OK',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            );


                          } else {
                            print('not uploaded');
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
