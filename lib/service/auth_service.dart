import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_list/models/app_user.dart';

class AuthService {
  //connected flutter with firebse auth
static final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
//sign up a new user
static Future<AppUser?> SignUp(String email,String password)async{
  try{
 final UserCredential credential=await _firebaseAuth.createUserWithEmailAndPassword
 (email: email, password: password);
 if(credential.user != null){
  return AppUser(
    email: credential.user!.email!,
     uid: credential.user!.uid,
     );  
 }
 return null;
  }catch(p){
    return null;
  }
}
//sign in a user
static Future<AppUser?> SignIn(String email, String password) async {
  try {
    final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
    return credential.user != null 
        ? AppUser.fromFirebaseUser(credential.user!) 
        : null;
  } on FirebaseAuthException catch (e) {
    print('🔥 خطأ Firebase: ${e.code} - ${e.message}');
    rethrow;
  } catch (e) {
    print('❌ خطأ غير متوقع: $e');
    rethrow;
  }
}


//log out
static Future<void> signOut() async{
  await _firebaseAuth.signOut();
}

}