import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/sample_data.dart';
import '../models/artist_model.dart';
import 'artist_songs_screen.dart';

class ArtistScreen extends StatelessWidget {
  final AudioPlayer audioPlayer;

  ArtistScreen({required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artists'),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      body: FutureBuilder<List<Artist>>(
        future: loadSampleArtists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No artists found'));
          } else {
            final artists = snapshot.data!;
            return ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                final artist = artists[index];
                return ListTile(
                  title: Text(artist.name),
                  subtitle: Text(artist.bio),
                  leading: Image.asset(artist.profileImageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtistSongsScreen(
                          artist: artist,
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