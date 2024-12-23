class Song {
  final String id;
  final String title;
  final String albumId;
  final String artistId;
  final Duration duration;
  final String audioUrl;

  Song({
    required this.id,
    required this.title,
    required this.albumId,
    required this.artistId,
    required this.duration,
    required this.audioUrl,
  });
}