import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/play_list_model.dart';

class PlaylistScreen extends StatefulWidget {
  final List<Song> songs;

  PlaylistScreen({required this.songs});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<Song> favoriteSongs = [];
  Song? currentlyPlaying;

  void toggleFavorite(Song song) {
    setState(() {
      if (favoriteSongs.contains(song)) {
        favoriteSongs.remove(song);
      } else {
        favoriteSongs.add(song);
      }
    });
  }

  void playSong(Song song) {
    setState(() {
      currentlyPlaying = song;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Playlist',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (currentlyPlaying != null)
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/album_screen.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentlyPlaying!.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    currentlyPlaying!.artistId,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.songs.length,
              itemBuilder: (context, index) {
                final song = widget.songs[index];
                return ListTile(
                  leading: Icon(Icons.music_note, color: Colors.white),
                  title: Text(song.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text('Artist: ${song.artistId}', style: TextStyle(color: Colors.white70)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          favoriteSongs.contains(song) ? Icons.favorite : Icons.favorite_border,
                          color: favoriteSongs.contains(song) ? Colors.red : Colors.white,
                        ),
                        onPressed: () => toggleFavorite(song),
                      ),
                      IconButton(
                        icon: Icon(currentlyPlaying == song ? Icons.pause : Icons.play_arrow, color: Colors.white),
                        onPressed: () => playSong(song),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}