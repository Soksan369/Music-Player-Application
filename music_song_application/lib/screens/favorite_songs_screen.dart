import 'package:flutter/material.dart';
import '../models/play_list_model.dart';

class FavoriteSongsScreen extends StatelessWidget {
  final List<Song> favoriteSongs;

  FavoriteSongsScreen({required this.favoriteSongs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: favoriteSongs.isEmpty
          ? Center(
              child: Text(
                'No favorite songs yet',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                final song = favoriteSongs[index];
                return ListTile(
                  leading: Icon(Icons.music_note, color: Colors.white),
                  title: Text(song.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text('Artist: ${song.artistId}', style: TextStyle(color: Colors.white70)),
                );
              },
            ),
    );
  }
}