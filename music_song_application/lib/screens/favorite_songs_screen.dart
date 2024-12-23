import 'package:flutter/material.dart';
import '../models/play_list_model.dart';
import '../data/sample_data.dart';

class FavoriteSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
      ),
      body: Center(
        child: Text('Favorite Songs Screen'),
      ),
    );
  }
}