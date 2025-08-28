import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/models/app_user.dart';
import 'package:flutter_todo_list/profile/profile.dart';
import 'package:flutter_todo_list/provider/todo_stream_provider.dart'; 
import 'package:flutter_todo_list/screen/home/priority.dart';
import 'package:flutter_todo_list/screen/home/show_dialog_edit.dart';
import 'package:flutter_todo_list/service/firestore_todo.dart';
import 'package:flutter_todo_list/style/button_style.dart';
import 'package:flutter_todo_list/style/textStyle.dart';
import 'package:flutter_todo_list/models/todo.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final AppUser user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titKey = GlobalKey<FormState>();
  TextEditingController _Titlecontroller = TextEditingController();
  TextEditingController _Descrcontroller = TextEditingController();
  Priority _selectedPriority = Priority.Low;

  @override
  void dispose() {
    _Titlecontroller.dispose();
    _Descrcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadingText('Todo List'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => ProfileApp(user: widget.user),
                  ),
                );
              },
              icon: Icon(Icons.person, size: 50, color: Colors.blue),
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final todosAsync = ref.watch(todoStreamProvider);

          return todosAsync.when(
            data: (todos) {
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (_, index) {
                          return Container(
                            child: EditDatas(
                              todos: todos[index],
                              index: index,
                              color: todos[index].priority.color,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            child: Icon(Icons.add),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: TitleText('Todo'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    height: 250,
                                    child: Form(
                                      key: _titKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 30),
                                            TextFormField(
                                              controller: _Titlecontroller,
                                              maxLength: 20,
                                              decoration: InputDecoration(
                                                hintText: "Title",
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "You must write Title";
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            TextFormField(
                                              controller: _Descrcontroller,
                                              maxLines: null,
                                              decoration: InputDecoration(
                                                hintText: "Description",
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            DropdownButtonFormField(
                                              value: _selectedPriority,
                                              items: Priority.values.map((p) {
                                                return DropdownMenuItem(
                                                  value: p,
                                                  child: Text(p.name),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedPriority = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                      child: Column(
                                        children: [
                                          StyleButton(
                                            onPressed: () {
                                              if (_titKey.currentState!
                                                  .validate()) {
                                                final String newId = uuid.v4();
                                                final newTodo = Todo(
                                                  id: newId,
                                                  title: _Titlecontroller.text
                                                      .trim(),
                                                  description: _Descrcontroller
                                                      .text
                                                      .trim(),
                                                  priority: _selectedPriority,
                                                  userId: widget.user.uid,
                                                );

                                                FirestoreTodo.addTodo(newTodo);
                                                _Titlecontroller.clear();
                                                _Descrcontroller.clear();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: StyleText('Save'),
                                          ),
                                          SizedBox(height: 10),
                                          StyleButton(
                                            onPressed: () {
                                              _Titlecontroller.clear();
                                              _Descrcontroller.clear();
                                              Navigator.pop(context);
                                            },
                                            child: StyleText('Cancel'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}
