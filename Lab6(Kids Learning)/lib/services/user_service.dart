import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserService {
  static late SharedPreferences _prefs;
  static Map<String, dynamic> _userData = {
    'name': 'Alex',
    'age': 7,
    'avatar': 'assets/avatars/boy1.png',
    'points': 0,
    'completedLessons': <String>[],
    'completedQuizzes': <String>[],
    'achievements': <String>[],
    'badges': <String>[],
  };

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    final userData = _prefs.getString('userData');
    if (userData != null) {
      _userData = json.decode(userData);
    } else {
      await _saveUserData();
    }
  }

  static Future<void> _saveUserData() async {
    await _prefs.setString('userData', json.encode(_userData));
  }

  static Map<String, dynamic> getUserData() {
    return Map<String, dynamic>.from(_userData);
  }

  static Future<void> updateUserData(Map<String, dynamic> updates) async {
    _userData.addAll(updates);
    await _saveUserData();
  }

  static Future<void> addPoints(int points) async {
    _userData['points'] = (_userData['points'] as int) + points;
    await _saveUserData();
  }

  static Future<void> completeLesson(String lessonId) async {
    if (!(_userData['completedLessons'] as List).contains(lessonId)) {
      (_userData['completedLessons'] as List).add(lessonId);
      await addPoints(10); // 10 points for completing a lesson
      await _saveUserData();
    }
  }

  static Future<void> completeQuiz(String quizId, int score, int totalQuestions) async {
    if (!(_userData['completedQuizzes'] as List).contains(quizId)) {
      (_userData['completedQuizzes'] as List).add(quizId);
    }
    
    // Add points based on score
    int earnedPoints = (score / totalQuestions * 20).round(); // Up to 20 points per quiz
    await addPoints(earnedPoints);
    
    // Check for achievements
    if (score == totalQuestions) {
      await unlockAchievement('Score 100% on any quiz');
      
      // Check for "Score 100% on 5 quizzes" achievement
      int perfectScores = (_userData['achievements'] as List)
          .where((achievement) => achievement == 'Score 100% on any quiz')
          .length;
      
      if (perfectScores >= 5) {
        await unlockAchievement('Score 100% on 5 quizzes');
      }
    }
    
    // Check for "Complete 10 quizzes" achievement
    if ((_userData['completedQuizzes'] as List).length >= 10) {
      await unlockAchievement('Complete 10 quizzes');
    }
    
    await _saveUserData();
  }

  static Future<void> unlockAchievement(String achievement) async {
    if (!(_userData['achievements'] as List).contains(achievement)) {
      (_userData['achievements'] as List).add(achievement);
      await addPoints(25); // 25 points for achievements
      await _saveUserData();
    }
  }

  static Future<void> awardBadge(String badge) async {
    if (!(_userData['badges'] as List).contains(badge)) {
      (_userData['badges'] as List).add(badge);
      await _saveUserData();
    }
  }

  static bool hasCompletedLesson(String lessonId) {
    return (_userData['completedLessons'] as List).contains(lessonId);
  }

  static bool hasCompletedQuiz(String quizId) {
    return (_userData['completedQuizzes'] as List).contains(quizId);
  }

  static bool hasAchievement(String achievement) {
    return (_userData['achievements'] as List).contains(achievement);
  }

  static bool hasBadge(String badge) {
    return (_userData['badges'] as List).contains(badge);
  }
}

