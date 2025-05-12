import 'package:cloud_firestore/cloud_firestore.dart';
import 'todo_model.dart'; // Import your Todo model

class FirestoreService {
  // Get collection reference
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos'); // Top-level collection

  // CREATE: Add a new todo
  Future<void> addTodo(String title, String userId) async {
    try {
       await _todosCollection.add({
        'title': title,
        'isDone': false,
        'userId': userId, // Store the user ID with the todo
        'createdAt': Timestamp.now(), // Store creation time
       });
    } catch (e) {
        print("Error adding todo: $e");
        // Handle error appropriately (e.g., show message to user)
    }
  }

  // READ: Get stream of todos for a specific user
  Stream<List<Todo>> getTodosStream(String userId) {
    return _todosCollection
        .where('userId', isEqualTo: userId) // Filter by user ID
        .orderBy('createdAt', descending: true) // Order by creation time
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Use the factory constructor from Todo model
        return Todo.fromFirestore(doc);
      }).toList();
    });
  }

  // UPDATE: Toggle todo's done status
  Future<void> updateTodoStatus(String docId, bool isDone) async {
     try {
        await _todosCollection.doc(docId).update({'isDone': isDone});
     } catch (e) {
         print("Error updating todo: $e");
         // Handle error
     }
  }

   // UPDATE: Edit todo title (Optional Enhancement)
  Future<void> updateTodoTitle(String docId, String newTitle) async {
     try {
        await _todosCollection.doc(docId).update({'title': newTitle});
     } catch (e) {
         print("Error updating todo title: $e");
         // Handle error
     }
  }

  // DELETE: Delete a todo
  Future<void> deleteTodo(String docId) async {
     try {
         await _todosCollection.doc(docId).delete();
     } catch (e) {
         print("Error deleting todo: $e");
         // Handle error
     }
  }
}