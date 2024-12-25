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
      title: 'ប្អូនស្រី',
      albumId: '2',
      artistId: '1',
      duration: Duration(minutes: 3, seconds: 45),
      audioUrl: 'assets/songs/Devid_song1.mp3',
    ),
    Song(
      id: '2',
      title: 'បងអ្នកយំអូនលួងគេ',
      albumId: '2',
      artistId: '1',
      duration: Duration(minutes: 4, seconds: 20),
      audioUrl: 'assets/songs/Devid_song2.mp3',
    ),
    Song(
      id: '3',
      title: 'មានអារម្មណ៍',
      albumId: '2',
      artistId: '2',
      duration: Duration(minutes: 5, seconds: 10),
      audioUrl: 'assets/songs/Tena_song1.mp3',
    ),
    Song(
      id: '4',
      title: 'អារម្មណ៍សល់',
      albumId: '2',
      artistId: '1',
      duration: Duration(minutes: 4, seconds: 29),
      audioUrl: 'assets/songs/Ah-rom-sol-devid.mp3',
    ),
    Song(
      id: '5',
      title: 'ទឹកលុយសម្លាប់ទឹកចិត្ត',
      albumId: '2',
      artistId: '3',
      duration: Duration(minutes: 4, seconds: 58),
      audioUrl: 'assets/songs/Chay Vireakyuth.mp3',
    ),
    Song(
      id: '6',
      title: 'កុំអោយគេឈឺចាប់ដោយសារបង',
      albumId: '2',
      artistId: '3',
      duration: Duration(minutes: 5, seconds: 25),
      audioUrl: 'assets/songs/Chhay Vireakyuth.mp3',
    ),
    Song(
      id: '7',
      title: 'គេងមិនលក់កុំភ្លេចcallរកបង',
      albumId: '2',
      artistId: '3',
      duration: Duration(minutes: 4, seconds: 36),
      audioUrl: 'assets/songs/keng-min-louk-call-mok-bong-Chay.mp3',
    ),
    Song(
      id: '8',
      title: 'កុំអោយគេឈឺចាប់ដោយសារបង',
      albumId: '2',
      artistId: '3',
      duration: Duration(minutes: 4, seconds: 21),
      audioUrl: 'assets/songs/Kom-oy-ke-chher-jab-Chay.mp3',
    ),
    Song(
      id: '9',
      title: 'មិនអស់អាល័យ',
      albumId: '1',
      artistId: '4',
      duration: Duration(minutes: 4, seconds: 03),
      audioUrl: 'assets/songs/min-ors-ahlai-Sin Sisamuth.mp3',
    ),
    Song(
      id: '10',
      title: 'អនអើយស្រីអន',
      albumId: '1',
      artistId: '4',
      duration: Duration(minutes: 6, seconds: 04),
      audioUrl: 'assets/songs/On-Sin.mp3',
    ),
    Song(
      id: '11',
      title: 'អស់លទ្ធភាពមើលថែអូន',
      albumId: '2',
      artistId: '3',
      duration: Duration(minutes: 4, seconds: 56),
      audioUrl: 'assets/songs/Os-Letepheab-Merl-Thae-Oun-Chhay-Virakyuth.mp3',
    ),
    Song(
      id: '12',
      title: 'ចង់ក្រសោប',
      albumId: '1',
      artistId: '4',
      duration: Duration(minutes: 4, seconds: 07),
      audioUrl: 'assets/songs/Sin Sisamuth-Jong Kro Sob.mp3',
    ),
    Song(
      id: '13',
      title: 'ចំបុីសៀមរាប',
      albumId: '1',
      artistId: '4',
      duration: Duration(minutes: 2, seconds: 54),
      audioUrl: 'assets/songs/Sin Sisamuth.mp3',
    ),
    Song(
      id: '14',
      title: 'ខឹងព្រោះស្រឡាញ់',
      albumId: '1',
      artistId: '4',
      duration: Duration(minutes: 3, seconds: 06),
      audioUrl: 'assets/songs/Sin-Sisamouth-Khg-pros.mp3',
    ),
    Song(
      id: '15',
      title: 'ហត់',
      albumId: '2',
      artistId: '1',
      duration: Duration(minutes: 4, seconds: 51),
      audioUrl: 'assets/songs/ហត - ប ដវឌ.mp3',
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
      title: 'បទពីដើម',
      releaseDate: DateTime(2021, 1, 1),
      coverImageUrl: 'assets/images/Album_Sin.jpg',
      songs: songs.where((song) => song.albumId == '1').toList(),
    ),
    Album(
      id: '2',
      title: 'បទសម័យ',
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
      bio: 'Cover song in pub',
      profileImageUrl: 'assets/images/ឌេវិដ.jpg',
      songs: songs.where((song) => song.artistId == '1').toList(),
    ),
    Artist(
      id: '2',
      name: 'Tena',
      bio: 'Khmer song singer',
      profileImageUrl: 'assets/images/Tena.jpg',
      songs: songs.where((song) => song.artistId == '2').toList(),
    ),
    Artist(
      id: '3',
      name: 'Chay Vireakyuth',
      bio: ' Khmer song singer',
      profileImageUrl: 'assets/images/Chay_Virakyuth.jpeg',
      songs: songs.where((song) => song.artistId == '3').toList(),
    ),
    Artist(
      id: '4',
      name: 'Sin Sisamuth',
      bio: 'King of Khmer song',
      profileImageUrl: 'assets/images/Sinn_Sisamouth.jpg',
      songs: songs.where((song) => song.artistId == '4').toList(),
    ),
    Artist(
      id: '5',
      name: 'Sin Sisamuth',
      bio: 'king of Khmer song',
      profileImageUrl: 'assets/images/artist-1.jpg',
      songs: songs.where((song) => song.artistId == '5').toList(),
    ),
  ];
}