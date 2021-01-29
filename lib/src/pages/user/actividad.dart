import 'package:flutter/material.dart';

class Actividad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}