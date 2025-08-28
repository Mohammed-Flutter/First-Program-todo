import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_list/models/todo.dart';

class FirestoreTodo {
  //connected  collection in firestore with flutterApp
  static final CollectionReference ref = 
      FirebaseFirestore.instance.collection('Todos');

//add data in documents in collection 
  static Future<void> addTodo(Todo todo) async {  
    await ref.doc(todo.id).set(todo.toMap()); 
  }

//update data in documents in collection 
  static Future<void> updateTodo(Todo todo) async {
    await ref.doc(todo.id).update(todo.toMap());
  }
//delete documents in collections
  static Future<void> removeTodo(Todo todo) async {
    await ref.doc(todo.id).delete();
  }
//fetch data in documents in collection and disply in screen
  static Stream<List<Todo>> getTodos(String userId) {
    print('🔍 [FIRESTORE] جلب TODOs للمستخدم: $userId'); 
    return ref
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          print('📦 [FIRESTORE] عدد TODOs: ${snapshot.docs.length}');
          //convert all documents to  object Todo
          //check on all documents
          return snapshot.docs.map((doc) {
            //get data documents as map
            final data = doc.data() as Map<String, dynamic>;
            //convert map to todo used fromMap
            return Todo.fromMap(data);
          }).toList();
        });
  }
}