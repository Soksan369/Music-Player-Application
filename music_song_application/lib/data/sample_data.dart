import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/play_list_model.dart';

Future<List<Song>> loadSampleSongs() async {
  // Load sample songs from assets or any other source
  // This is just a placeholder implementation
  return [
    Song(
      id: '1',
      title: 'Sample Song 1',
      albumId: '1',
      artistId: '1',
      duration: Duration(minutes: 3, seconds: 45),
      audioUrl: 'assets/songs/Devid_song1.mp3',
    ),
    Song(
      id: '2',
      title: 'Sample Song 2',
      albumId: '1',
      artistId: '1',
      duration: Duration(minutes: 4, seconds: 20),
      audioUrl: 'assets/songs/Devid_song2.mp3',
    ),
    Song(
      id: '3',
      title: 'Sample Song 3',
      albumId: '2',
      artistId: '2',
      duration: Duration(minutes: 5, seconds: 10),
      audioUrl: 'assets/songs/Tena_song1.mp3',
    ),
  ];
}

Future<List<Album>> loadSampleAlbums() async {
  // Load sample albums from assets or any other source
  // This is just a placeholder implementation
  final songs = await loadSampleSongs();
  return [
    Album(
      id: '1',
      title: 'Sample Album 1',
      releaseDate: DateTime(2021, 1, 1),
      coverImageUrl: 'assets/images/Album_Sin.jpg',
      songs: songs.where((song) => song.albumId == '1').toList(),
    ),
    Album(
      id: '2',
      title: 'Sample Album 2',
      releaseDate: DateTime(2021, 2, 1),
      coverImageUrl: 'assets/images/album_screen.jpg',
      songs: songs.where((song) => song.albumId == '2').toList(),
    ),
  ];
}

Future<List<Artist>> loadSampleArtists() async {
  // Load sample artists from assets or any other source
  // This is just a placeholder implementation
  final songs = await loadSampleSongs();
  return [
    Artist(
      id: '1',
      name: 'Devid',
      bio: 'Bio of Devid',
      profileImageUrl: 'assets/images/Sinn_Sisamouth.jpg',
      songs: songs.where((song) => song.artistId == '1').toList(),
    ),
    Artist(
      id: '2',
      name: 'Tena',
      bio: 'Bio of Tena',
      profileImageUrl: 'assets/images/artist-1.jpg',
      songs: songs.where((song) => song.artistId == '2').toList(),
    ),
  ];
}