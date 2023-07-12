import 'package:flutter/material.dart';
import 'package:weather_app/screens/home.dart';
import 'package:weather_app/screens/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.blue[700],
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
    ),
  ));
}
