import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'album_screen.dart';
import 'artist_screen.dart';
import 'favorite_songs_screen.dart';
import 'music_play_screen.dart';
import '../models/play_list_model.dart';
import '../data/sample_data.dart';

class HomeScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;

  HomeScreen({required this.audioPlayer});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Song> _audioFiles = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  Song? _currentPlayingFile;
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

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
  }

  @override
  void dispose() {
    widget.audioPlayer.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAudioFiles() async {
    try {
      final songs = await loadSampleSongs();
      if (mounted) {
        setState(() {
          _audioFiles = songs;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load audio files: $e'),
          ),
        );
      }
    }
  }

  void _playAudio(Song song) async {
    try {
      await widget.audioPlayer.stop(); // Stop any currently playing audio
      await widget.audioPlayer.play(UrlSource(song.audioUrl)); // Use UrlSource for web compatibility
      if (mounted) {
        setState(() {
          _currentPlayingFile = song;
          isPlaying = true;
        });
      }
      _navigateToMusicPlayScreen();
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

  void _navigateToMusicPlayScreen() {
    if (_currentPlayingFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MusicPlayScreen(
            audioPlayer: widget.audioPlayer,
            song: _currentPlayingFile!,
            audioFiles: _audioFiles,
          ),
        ),
      ).then((_) {
        if (mounted) {
          setState(() {
            isPlaying = widget.audioPlayer.state == PlayerState.playing;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player Organizer'),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FadeTransition(
              opacity: _animation,
              child: ListView.builder(
                itemCount: _audioFiles.length,
                itemBuilder: (context, index) {
                  final song = _audioFiles[index];
                  return ListTile(
                    title: Text(song.title),
                    onTap: () => _playAudio(song),
                  );
                },
              ),
            ),
          ),
          if (_currentPlayingFile != null)
            Container(
              color: Colors.grey[200],
              child: ListTile(
                leading: GestureDetector(
                  onTap: _navigateToMusicPlayScreen,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/images/album_screen.jpg'), // Replace with your album art
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(_currentPlayingFile!.title),
                trailing: IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _togglePlayPause,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add action
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 168, 8, 155),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Artist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 168, 8, 155),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(audioPlayer: widget.audioPlayer)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlbumScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtistScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteSongsScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}