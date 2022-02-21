import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;

class AboutUs extends StatefulWidget {
  static const id = "about_us_screen";

  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color(0x1E8603F1),
          ),
          child: const md.Markdown(
            data: """
# Socializing On Vocals
> Feel Connected

### Main Purpose
- As we have gone through the tough time of COVID crises, which taught us the importance of relationships. SOV is a socializing cum content sharing platform but with a little twist. The twist is that it is only **Audio** based platform. 

- Here, you can stream some interesting content while on a walk or without having to look at a screen. Being able to share thoughts and opinions, keeping an open dialogue, and having freedom of speech make this platform more powerful and the ability to emerge as a new artist. This platform encourages new artists and developers in that direction also. Being an introvert can be a shortcoming for some creative people who desperately want to create enthralling content but due to their shy nature, they hesitate. Sometimes lack of resources and accessories can be a hindrance to their creativity. Therefore, we come up with a solution by creating a platform for these people and help them to become the best version of themself. Simple steps like reading news, reciting poems, practicing speech could help you to become a great conversationalist.

### Team Members
- [Rohit Kumar Singh](https://github.com/rohitsinghkcodes)
- [Shivam Guglani](https://github.com/shivamkcodes)
- [Arsharaj Chauhan](https://github.com/arsharaj)
- [Dinki Gupta]()

### Privacy Policy

### Terms and Services

### License
> MIT License
""",
          ),
        ),
      ),
    );
  }
}