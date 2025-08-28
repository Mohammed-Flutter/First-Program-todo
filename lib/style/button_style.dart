import 'package:flutter/material.dart';
import 'package:flutter_todo_list/theme.dart';

class StyleButton extends StatelessWidget {
  const StyleButton({
    super.key,
    required this.child,
    required this.onPressed,
    });
final Widget child;
final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 160,
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
       // color: Colors.red,
        decoration: BoxDecoration(
        color: AppColor.SecondryColor,
       // backgroundBlendMode: BlendMode.softLight,
         borderRadius:const BorderRadius.all(Radius.circular(5))
        ),
        child: child,
        
      ),
      
   );
  }
}