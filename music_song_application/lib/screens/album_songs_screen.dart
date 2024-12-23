import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../models/play_list_model.dart';

class AlbumSongsScreen extends StatelessWidget {
  final Album album;

  AlbumSongsScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      body: ListView.builder(
        itemCount: album.songs.length,
        itemBuilder: (context, index) {
          final song = album.songs[index];
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