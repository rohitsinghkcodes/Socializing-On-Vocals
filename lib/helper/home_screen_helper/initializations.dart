
import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AudioPlayer audioPlayer = AudioPlayer();
PageController pageController = PageController(initialPage: 0);

String loggedInUserid = "";
bool isPlaying = true;
bool isLiked = false;
bool likeSwitch = false;
bool showSpinner = false;
List<dynamic> songList = [];
List<dynamic> likesList = [];
int audioLikesCount = 0;
int currentAudioNo = 0;
late String audioTitle = "hello";
int playlistSize = 0;
bool idDetailsLoaded = false;
late String songId = "";
Icon icon = const Icon(Icons.mic_rounded);
//for comment section
List commentList = [];
bool loadingComment = false;
final formKey = GlobalKey<FormState>();
final TextEditingController commentController = TextEditingController();

AnimateIconController controllerIcon = AnimateIconController();

//audio slider
Duration duration = const Duration();
Duration position = const Duration();