
import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AudioPlayer audioPlayer = AudioPlayer();
PageController pageController = PageController(initialPage: 0);
bool isPlaying = true;
bool isLiked = false;
bool showSpinner = false;
List<dynamic> songList = [];
int currentAudioNo = 0;
late String audioTitle = "hello";
int playlistSize = 0;
bool idDetailsLoaded = false;
Icon icon = const Icon(Icons.mic_rounded);

AnimateIconController controllerIcon = AnimateIconController();

//audio slider
Duration duration = const Duration();
Duration position = const Duration();