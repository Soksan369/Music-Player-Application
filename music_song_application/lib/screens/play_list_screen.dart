import 'package:flutter/material.dart';
import '../models/favourite_song_model.dart';
import '../models/play_list_model.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<FavoriteSong> favoriteSongs = [];

  void toggleFavorite(String songId) {
    setState(() {
      final favorite = favoriteSongs.firstWhere(
        (fav) => fav.songId == songId,
        orElse: () => FavoriteSong(id: '', songId: ''),
      );
      if (favorite.id.isEmpty) {
        favoriteSongs.add(FavoriteSong(id: DateTime.now().toString(), songId: songId));
      } else {
        favoriteSongs.removeWhere((fav) => fav.songId == songId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      body: ListView.builder(
        itemCount: favoriteSongs.length,
        itemBuilder: (context, index) {
          final favoriteSong = favoriteSongs[index];
          return ListTile(
            title: Text('Song ID: ${favoriteSong.songId}'), // Replace with actual song title
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () => toggleFavorite(favoriteSong.songId),
            ),
          );
        },
      ),
    );
  }
}
