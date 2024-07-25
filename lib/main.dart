import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Homepage(),
      },
    ),
  );
}
