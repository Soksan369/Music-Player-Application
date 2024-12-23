import 'play_list_model.dart';

class Album {
  final String id;
  final String title;
  final DateTime releaseDate;
  final String coverImageUrl;
  final List<Song> songs;

  Album({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.coverImageUrl,
    required this.songs,
  });
}