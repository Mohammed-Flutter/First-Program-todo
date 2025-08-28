// في ملف main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo_list/provider/auth_provider.dart';
import 'package:flutter_todo_list/screen/home/home_page.dart';
import 'package:flutter_todo_list/screen/welcom/welcom.dart';
import 'package:flutter_todo_list/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuth = ref.watch(authProvider);

    return MaterialApp(
      title: "Flutter Todo List",
      theme: ThemeColors,
      home: userAuth.when(
        data: (user) {
          if (user == null) {
            return const welcomPage();
          }
          return Consumer(
            builder: (context,ref,child) {
              return HomePage(user: user);
            }
          );
          
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stack) => const Scaffold(
          body: Center(
            child: Text('حدث خطأ في تحميل البيانات.'),
          ),
        ),
      ),
    );
  }
}