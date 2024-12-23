import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player Organizer',
      home: HomeScreen(audioPlayer: audioPlayer),
    );
  }
}