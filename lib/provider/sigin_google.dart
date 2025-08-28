import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SiginGoogle {
  //connected firebase with flutter
  static final FirebaseAuth _auth = FirebaseAuth.instance;
    //connected SignINGoogle with flutter
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
//add account google
  static Future<User?> signInGoogle() async {
    try {
      print('بدء عملية تسجيل Google...');
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('لم يتم اختيار أي حساب');
        return null;
      }
      
      print('تم اختيار الحساب: ${googleUser.email}');
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('تم الحصول على بيانات المصادقة');
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      print('جاري تسجيل الدخول إلى Firebase...');
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      print('تم التسجيل بنجاح! المستخدم: ${userCredential.user?.uid}');
      return userCredential.user;
      
    } catch (e) {
      print('❌ خطأ كامل في تسجيل Google: $e');
      rethrow;
    }
  }
  static Future<void> signOutGoogle()async {
    _googleSignIn.signOut();
    _auth.signOut();
  }
}