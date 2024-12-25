import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/play_list_model.dart';
import 'play_list_screen.dart';

class MusicPlayScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final Song song;
  final List<Song> audioFiles;

  MusicPlayScreen({
    required this.audioPlayer,
    required this.song,
    required this.audioFiles,
  });

  @override
  _MusicPlayScreenState createState() => _MusicPlayScreenState();
}

class _MusicPlayScreenState extends State<MusicPlayScreen> {
  bool isPlaying = false;
  int currentIndex = 0;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isFavourite = false;
  Song? _currentPlayingFile;
  bool isSeeking = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.audioFiles.indexOf(widget.song);

    widget.audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted && !isSeeking) {
        setState(() {
          currentPosition = position;
        });
      }
    });

    widget.audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          totalDuration = duration;
        });
      }
    });

    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    _playAudio(widget.song);
  }

  void _playAudio(Song song) async {
    if (_currentPlayingFile?.audioUrl != song.audioUrl) {
      try {
        await widget.audioPlayer.play(UrlSource(song.audioUrl));
        if (mounted) {
          setState(() {
            _currentPlayingFile = song;
            isPlaying = true;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to play audio: $e'),
            ),
          );
        }
      }
    } else {
      _togglePlayPause();
    }
  }

  void _togglePlayPause() {
    if (isPlaying) {
      widget.audioPlayer.pause();
    } else {
      widget.audioPlayer.resume();
    }
    if (mounted) {
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  }

  void _playNext() {
    if (currentIndex < widget.audioFiles.length - 1) {
      currentIndex++;
      _playAudio(widget.audioFiles[currentIndex]);
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _playAudio(widget.audioFiles[currentIndex]);
    }
  }

  void _toggleFavourite() {
    if (mounted) {
      setState(() {
        isFavourite = !isFavourite;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavourite ? 'Added to Favourites' : 'Removed from Favourites'),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Playing Now',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_play, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaylistScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/album_screen.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              widget.audioFiles[currentIndex].title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              widget.audioFiles[currentIndex].artistId,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Slider(
              activeColor: Colors.blue,
              inactiveColor: Colors.white24,
              value: totalDuration.inSeconds > 0
                  ? currentPosition.inSeconds.toDouble().clamp(0, totalDuration.inSeconds.toDouble())
                  : 0,
              min: 0,
              max: totalDuration.inSeconds.toDouble() > 0 ? totalDuration.inSeconds.toDouble() : 1,
              onChanged: (value) {
                setState(() {
                  isSeeking = true;
                  currentPosition = Duration(seconds: value.toInt());
                });
              },
              onChangeEnd: (value) async {
                await widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                setState(() {
                  isSeeking = false;
                  currentPosition = Duration(seconds: value.toInt());
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(currentPosition),
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  _formatDuration(totalDuration),
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _playPrevious,
                  iconSize: 48.0,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _togglePlayPause,
                    iconSize: 48.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _playNext,
                  iconSize: 48.0,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
