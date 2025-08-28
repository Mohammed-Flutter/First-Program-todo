import 'package:flutter/material.dart';

class AppColor {

static Color PrimaryColor =  Color(0xFF1E88E5);
static Color PrimaryAcsent = const Color(0xFF8E24AA);
static Color SecondryColor = const Color.from(alpha: 1, red: 1, green: 0.012, blue: 0.012);
static Color Surface = const Color(0xFF1E1E1E);
static Color TitleColor = const Color(0xFFFFFFFF);
static Color TextColor =const Color(0xFFB0B0B0);
static Color background =const Color(0xFF121212);
static const Color error = Color(0xFFCF6679); 
static Color Success =const Color(0xFF4CAF50);

}
ThemeData ThemeColors  =ThemeData(
  brightness: Brightness.dark,
  
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.background
    ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: AppColor.TitleColor,
      fontSize: 28,
      fontWeight: FontWeight.bold, 
      overflow: TextOverflow.ellipsis
    ),
    headlineMedium: TextStyle(
      color: AppColor.TitleColor,
      fontSize: 32,
      fontWeight: FontWeight.bold, 
      wordSpacing: 3
      
  ),
  bodyMedium: TextStyle(
      color: AppColor.TitleColor,
      fontSize: 22,
      fontWeight: FontWeight.bold, 
  ),
  labelMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
  ),
  
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.SecondryColor,
  ),
  
);