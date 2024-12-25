import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/artist_model.dart';
import '../models/play_list_model.dart';
import 'music_play_screen.dart';

class ArtistSongsScreen extends StatelessWidget {
  final Artist artist;
  final AudioPlayer audioPlayer;

  ArtistSongsScreen({required this.artist, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      body: ListView.builder(
        itemCount: artist.songs.length,
        itemBuilder: (context, index) {
          final song = artist.songs[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text('Duration: ${song.duration.inMinutes}:${song.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayScreen(
                    audioPlayer: audioPlayer,
                    song: song,
                    audioFiles: artist.songs,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}