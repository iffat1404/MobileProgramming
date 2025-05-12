import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id; // Document ID from Firestore
  final String title;
  bool isDone;
  final String userId; // To associate todo with a user
  final Timestamp createdAt; // Optional: for sorting

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.userId,
    required this.createdAt,
  });

  // Factory constructor to create a Todo from a Firestore document
  factory Todo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: data['title'] ?? '', // Provide default value if null
      isDone: data['isDone'] ?? false,
      userId: data['userId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(), // Provide default
    );
  }

  // Method to convert Todo instance to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'isDone': isDone,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}