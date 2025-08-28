import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  AppUser({required this.email,required this.uid, });

  final String email;
  final String uid;
  
  factory AppUser.fromFirebaseUser(User user) {
  return AppUser(
    email: user.email ?? 'no-email@example.com', // ✅ قيمة افتراضية
    uid: user.uid,
  );
}
}
