import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/play_list_model.dart';

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

  @override
  void initState() {
    super.initState();
    currentIndex = widget.audioFiles.indexOf(widget.song);

    widget.audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
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

    _playAudio(widget.song.audioUrl);
  }

  @override
  void dispose() {
    widget.audioPlayer.stop();
    super.dispose();
  }

  void _playAudio(String filePath) async {
    try {
      await widget.audioPlayer.stop(); // Stop any currently playing audio
      await widget.audioPlayer.play(UrlSource(filePath)); // Use UrlSource for web compatibility
      if (mounted) {
        setState(() {
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
      _playAudio(widget.audioFiles[currentIndex].audioUrl);
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _playAudio(widget.audioFiles[currentIndex].audioUrl);
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
      appBar: AppBar(
        title: Text('Now Playing'),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            widget.audioPlayer.stop();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album Art
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/album_screen.jpg'), // Replace with your album art
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add to Favourite Button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
                onPressed: _toggleFavourite,
                iconSize: 32.0,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            // Song Title
            Text(
              widget.audioFiles[currentIndex].title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // Progress Bar
            Slider(
              value: currentPosition.inSeconds.toDouble(),
              max: totalDuration.inSeconds.toDouble(),
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    currentPosition = Duration(seconds: value.toInt());
                  });
                }
              },
              onChangeEnd: (value) {
                widget.audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            // Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(currentPosition)),
                Text(_formatDuration(totalDuration)),
              ],
            ),
            SizedBox(height: 20),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _playPrevious,
                  iconSize: 64.0,
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _togglePlayPause,
                  iconSize: 64.0,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _playNext,
                  iconSize: 64.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}