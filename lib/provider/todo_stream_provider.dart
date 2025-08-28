import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/provider/auth_provider.dart';
import 'package:flutter_todo_list/service/firestore_todo.dart';
import 'package:flutter_todo_list/models/todo.dart';

final todoStreamProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
  final appUser = ref.watch(authProvider).value; // تغيير من user إلى appUser
  
  if (appUser == null) {
    print('👤 [STREAM] لا يوجد مستخدم، إرجاع قائمة فارغة');
    return Stream.value([]);
  }
  
  print('👤 [STREAM] جلب TODOs للمستخدم: ${appUser.uid}');
  return FirestoreTodo.getTodos(appUser.uid);
});