import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../models/play_list_model.dart';

class ArtistSongsScreen extends StatelessWidget {
  final Artist artist;

  ArtistSongsScreen({required this.artist});

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
              // Handle song tap to play the song
            },
          );
        },
      ),
    );
  }
}