import 'package:flutter/material.dart';

enum Priority {
High(
  color :Colors.red,name:"High"
),

Medium(
  color :Colors.amber,name:"Medium"
),
Low(
  color: Colors.green,name:"Low"
);

final Color color;
final String name;
const Priority({ required this .color,required this.name});

}
