import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screen/welcom/sign_in.dart';
import 'package:flutter_todo_list/screen/welcom/sign_up.dart';
import 'package:flutter_todo_list/style/textStyle.dart';
import 'package:google_fonts/google_fonts.dart';

class welcomPage extends StatefulWidget {
  const welcomPage({super.key});
  @override
  State<welcomPage> createState() => _welcomPageState();
}

class _welcomPageState extends State<welcomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DelayedDisplay(
        delay: Duration(seconds: 2),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/img/to_do.png", width: 350, height: 350),

                Center(
                  child: Text(
                    'The best app for your todo  ',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 45, wordSpacing: 5),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                Column(
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.blue[900],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => SignUp()),
                        );
                      },
                      child: StyleText('Sign Up'),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (c) => SignIn()),
                            );
                          },
                          child: StyleText('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
