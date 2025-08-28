import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/models/app_user.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) {
    if (user != null) {
      return AppUser(email: user.email ?? 'no-email', uid: user.uid);
    }
    return null;
  });
});