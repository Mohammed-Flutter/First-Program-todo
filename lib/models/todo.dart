
import 'package:flutter_todo_list/screen/home/priority.dart';

class Todo   {
final  String title;
final  String description;
final  Priority priority;
final   String id;
final String userId;
  
  Todo({
    required this.title,
   required  this.description,
    required  this.priority,
    required  this.id,
    required this.userId
});

Map<String,dynamic> toMap(){
  return {
      'title':title,
      'description':description,
      'priority':priority.name,
      'id':id,
      'userId':userId
  };
}

factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title:map['title'],
       description:map['description'],
        priority:Priority.values.firstWhere((p)=>p.name==map['priority']),
         id:map['id'],
         userId: map['userId']
         );
  }
}




