import 'package:flutter/material.dart';
import 'package:new_trip_challenger/home/home_page.dart';
import 'package:new_trip_challenger/register/register_page.dart';
import 'package:new_trip_challenger/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}
