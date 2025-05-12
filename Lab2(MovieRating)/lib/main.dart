import 'package:flutter/material.dart';
import 'form.dart';

void main() {
  runApp(MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewFormScreen(),
    );
  }
}
