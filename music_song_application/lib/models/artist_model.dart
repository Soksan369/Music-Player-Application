import 'play_list_model.dart';

class Artist {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final List<Song> songs;

  Artist({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.songs,
  });
}