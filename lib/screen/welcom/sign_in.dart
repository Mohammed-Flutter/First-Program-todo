import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/app_user.dart';
import 'package:flutter_todo_list/provider/sigin_google.dart';
import 'package:flutter_todo_list/service/auth_service.dart';
import 'package:flutter_todo_list/style/button_style.dart';
import 'package:flutter_todo_list/style/textStyle.dart';
import 'package:firebase_auth/firebase_auth.dart'; // أضف هذا
import 'package:flutter_todo_list/screen/home/home_page.dart'; // أضف هذا

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formkey.currentState!.validate()) {
      try {
        await AuthService.SignIn(_email.text.trim(), _password.text.trim());

        // بعد نجاح التسجيل، انتقل إلى HomePage
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(
                user: AppUser.fromFirebaseUser(
                  FirebaseAuth.instance.currentUser!,
                ),
              ),
            ),
          );
          print('Login successful');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        switch (e.code) {
          case 'user-not-found':
            errorMessage = '❌ الحساب غير مسجل!';
            break;
          case 'wrong-password':
          case 'invalid-credential': // <- نعاملهم بنفس الطريقة
            errorMessage = '❌ الإيميل أو كلمة المرور خاطئة';
            break;
          case 'invalid-email':
            errorMessage = '❌ البريد الإلكتروني غير صحيح';
            break;
          case 'user-disabled':
            errorMessage = '❌ الحساب موقوف';
            break;
          case 'too-many-requests':
            errorMessage = '⏰ كثير محاولات! حاول لاحقاً';
            break;
          default:
            errorMessage = '❌ فشل التسجيل: ${e.code}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.white54),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingText('Sign In'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 50),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: StyleText('Welcom to the application ')),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: labelStyle('Email'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: labelStyle('Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 chars long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  StyleButton(
                    onPressed: _signIn, // استدعاء الدالة الجديدة
                    child: StyleText('Sign In'),
                  ),

                  SizedBox(height: 100),

                  Center(child: const StyleText('You can Sign up through')),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            final User? user = await SiginGoogle.signInGoogle();
                            if (user != null) {
                              await Future.delayed(Duration(milliseconds: 300));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => HomePage(
                                    user: AppUser.fromFirebaseUser(user),
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            print('خطأ في تسجيل Google: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('فشل التسجيل: $e')),
                            );
                          }
                        },
                        icon: Image.asset(
                          "assets/img/google_logo.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/facebook_logo.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/instgram_logo.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
