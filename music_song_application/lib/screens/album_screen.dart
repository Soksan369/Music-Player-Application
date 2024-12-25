import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/sample_data.dart';
import '../models/album_model.dart';
import 'album_songs_screen.dart';

class AlbumScreen extends StatelessWidget {
  final AudioPlayer audioPlayer;

  AlbumScreen({required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      body: FutureBuilder<List<Album>>(
        future: loadSampleAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No albums found'));
          } else {
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.title),
                  subtitle: Text('Release Date: ${album.releaseDate.toLocal()}'),
                  leading: Image.asset(album.coverImageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlbumSongsScreen(
                          album: album,
                          audioPlayer: audioPlayer,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}