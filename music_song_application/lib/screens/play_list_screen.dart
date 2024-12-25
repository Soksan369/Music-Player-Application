import 'package:flutter/material.dart';
import '../models/play_list_model.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<Song> _songs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();

  void _addSong() {
    _titleController.clear();
    _artistController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Song'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _artistController,
                decoration: InputDecoration(labelText: 'Artist'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _songs.add(Song(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    albumId: '', // Placeholder, update as needed
                    artistId: '', // Placeholder, update as needed
                    duration: Duration(minutes: 3), // Placeholder, update as needed
                    audioUrl: '', // Placeholder, update as needed
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editSong(int index) {
    _titleController.text = _songs[index].title;
    _artistController.text = _songs[index].artistId; // Assuming artistId is the correct property
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Song'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _artistController,
                decoration: InputDecoration(labelText: 'Artist'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _songs[index] = Song(
                    id: _songs[index].id,
                    title: _titleController.text,
                    albumId: _songs[index].albumId,
                    artistId: _artistController.text, // Assuming artistId is the correct property
                    duration: _songs[index].duration,
                    audioUrl: _songs[index].audioUrl,
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSong(int index) {
    setState(() {
      _songs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Playlist',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _addSong,
          ),
        ],
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final Song song = _songs.removeAt(oldIndex);
            _songs.insert(newIndex, song);
          });
        },
        children: [
          for (int index = 0; index < _songs.length; index++)
            ListTile(
              key: ValueKey(_songs[index]),
              leading: Icon(Icons.music_note, color: Colors.white),
              title: Text(_songs[index].title, style: TextStyle(color: Colors.white)),
              subtitle: Text('Artist: ${_songs[index].artistId}', style: TextStyle(color: Colors.white70)), // Assuming artistId is the correct property
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () => _editSong(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () => _deleteSong(index),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}