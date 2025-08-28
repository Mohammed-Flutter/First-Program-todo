import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/models/app_user.dart';
import 'package:flutter_todo_list/screen/home/home_page.dart';
import 'package:flutter_todo_list/service/auth_service.dart';
import 'package:flutter_todo_list/style/button_style.dart';
import 'package:flutter_todo_list/style/textStyle.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const HeadingText('Sign Up'), centerTitle: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 50),
          child: Container(
            padding: EdgeInsets.all(10),
            //color: Colors.indigo[600],
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 40,),
                  Center(child: StyleText('Welcom to the application ')),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: const labelStyle('Email'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _password,
                    obscureText: true,

                    decoration: InputDecoration(
                      label: const labelStyle('Password'),
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
                  const SizedBox(height: 30),
                  StyleButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        final email = _email.text.trim();
                        final password = _password.text.trim();
                        try {
                          await AuthService.SignUp(email, password);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (c) => HomePage(
                                user: AppUser.fromFirebaseUser(
                                  FirebaseAuth.instance.currentUser!,
                                ),
                              ),
                            ),
                          );
                          print('New account created successfully');
                        } catch (e) {
                          return null;
                        }
                      }
                    },
                    child: const StyleText('Sign Up'),
                  ),
                  SizedBox(height: 100),

                  Center(child: const StyleText('You can Sign up through')),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
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
