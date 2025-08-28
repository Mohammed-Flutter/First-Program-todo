import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/app_user.dart';
import 'package:flutter_todo_list/provider/sigin_google.dart';
import 'package:flutter_todo_list/screen/welcom/welcom.dart';
import 'package:flutter_todo_list/service/auth_service.dart';
import 'package:flutter_todo_list/style/button_style.dart';
import 'package:flutter_todo_list/style/textStyle.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: HeadingText('Profile'), centerTitle: true),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Icon(Icons.person, size: 350, color: Colors.blue[900]),
              ),
              SizedBox(height: 10),
              Text('email :'),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.none,
                controller: _email,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  hintText: (user.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: StyleButton(
              onPressed: () async {
                try {
                  await AuthService.signOut();
                  await SiginGoogle.signOutGoogle();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => const welcomPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('فشل تسجيل الخروج: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const StyleText("Log Out"),
            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
