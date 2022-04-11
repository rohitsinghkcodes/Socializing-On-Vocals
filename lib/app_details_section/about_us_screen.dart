import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  static const id = "about_us_screen";

  @override
  Widget build(BuildContext context) {

    final ScrollController _scrollController = ScrollController();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
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
              Center(child:  Text('About ',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
              Center(child:  Text('Us',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
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
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Socializing On Vocals" or "SOV" is an application that connect people using audio. It is an amalgamation of technologies and ideas from major social media platforms. Here the user can upload songs, make a collection of poetry and also listen to audios that is being uploaded by other people. We want each and every person to break the social boundary through this application.', style: content),
              ),
              const SizedBox(height: 20),
              Text("Developer Team", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("🔹 Rohit kumar Singh\n"
                    "🔹 Shivam Guglani\n"
                    "🔹 Arsharaj Chauhan\n"
                    "🔹 Dinki Gupta"
, style: content),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
