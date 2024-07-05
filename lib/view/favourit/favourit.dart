// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rexparts/widget/favourate_widget.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Favourites", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: const Fav(),
    );
  }
}
