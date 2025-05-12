import 'package:flutter/material.dart';

class Lesson {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> content;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.content,
  });
}

class WordLesson {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<Word> words;

  const WordLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.words,
  });
}

class Word {
  final String letter;
  final String word;
  final String imagePath;

  const Word({
    required this.letter,
    required this.word,
    required this.imagePath,
  });
}

