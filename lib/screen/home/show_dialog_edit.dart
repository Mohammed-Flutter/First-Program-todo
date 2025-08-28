import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/screen/home/priority.dart';
import 'package:flutter_todo_list/service/firestore_todo.dart';
import 'package:flutter_todo_list/style/textStyle.dart';
import 'package:flutter_todo_list/models/todo.dart';

class EditDatas extends ConsumerWidget {
  const EditDatas({
    super.key,
    required this.index,
    required this.todos,
    required this.color,
  });
  
  final int index;
  final Todo todos;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _titKey = GlobalKey<FormState>();
    TextEditingController _Titlecontroller = TextEditingController(text: todos.title);
    TextEditingController _Descrcontroller = TextEditingController(text: todos.description);
    Priority _selectedPriority = todos.priority;

    return Container(
      color: todos.priority.color.withOpacity(0.6),
      child: ListTile(
        title: Center(child: TitleText(todos.title)),
        subtitle: labelStyle(todos.description),
        trailing: Column(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Edit Todo'),
                    content: Form(
                      key: _titKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _Titlecontroller,
                            style: TextStyle(fontSize: 24),
                          ),
                          TextFormField(
                            controller: _Descrcontroller,
                            style: TextStyle(fontSize: 24),
                          ),
                          DropdownButtonFormField<Priority>(
                            value: _selectedPriority,
                            items: Priority.values.map((p) {
                              return DropdownMenuItem(
                                value: p,
                                child: Text(p.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                _selectedPriority = value;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      // زر الحذف
                      IconButton(
                        onPressed: () {
                          FirestoreTodo.removeTodo(todos); // حذف من Firestore مباشرة
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.delete),
                      ),

                      // زر التحديث
                      IconButton(
                        onPressed: () {
                          final Newtitle = _Titlecontroller.text.trim();
                          final Newdescription = _Descrcontroller.text.trim();
                          final NewPriority = _selectedPriority;
                          final id = todos.id;
                          final userid = todos.userId;
                          
                          final newtodo = Todo(
                            title: Newtitle,
                            description: Newdescription,
                            priority: NewPriority,
                            id: id,
                            userId: userid,
                          );
                          
                          FirestoreTodo.updateTodo(newtodo); // تحديث في Firestore مباشرة
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.done),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}