import 'dart:math';

import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {

  Color get color => null;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [

          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return new Container(
                        color: randomColor(color),
                        height: 150.0);
                  }
              )
          )



        ],
      ),
    );
  }

  randomColor(Color color) {
    final r = Random().nextInt(255);
    final g = Random().nextInt(255);
    final b = Random().nextInt(255);
    final color = Color.fromRGBO(r, g, b, 1);
    return color;
  }
}
