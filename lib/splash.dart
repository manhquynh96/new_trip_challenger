import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_trip_challenger/login/login_page.dart';

class Splash extends StatelessWidget {
  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset('assets/images/ui_9.png', fit: BoxFit.cover),
    );
  }

  Widget _buildTextTop() {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      alignment: Alignment.topCenter,
      child: Text(
        'Trip Challenger',
        style: TextStyle(
            fontSize: 43, color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextBot() {
    return Text(
      'Love is like a butterfly if you let it go and it comes back',
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage())),
    );
    return Scaffold(
      body: Stack(
        children: [
          _buildImage(),
          _buildTextTop(),
          Positioned(
            left: 35,
            bottom: 75,
            child: _buildTextBot(),
          ),
        ],
      ),
    );
  }
}
