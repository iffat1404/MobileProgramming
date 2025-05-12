import 'package:flutter/material.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficulty,
    required this.questions,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class PictureWordQuiz {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;
  final List<PictureWordQuestion> questions;

  PictureWordQuiz({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficulty,
    required this.questions,
  });
}

class PictureWordQuestion {
  final String imagePath;
  final String correctAnswer;
  final String hint;

  PictureWordQuestion({
    required this.imagePath,
    required this.correctAnswer,
    required this.hint,
  });
}

