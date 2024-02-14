import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrun;

  MyMario({this.direction, this.midrun});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: 50,
        height: 50,
        child: midrun
            ? Image.asset('lib/images/dur.png')
            : Image.asset('lib/images/run.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: 50,
          height: 50,
          child: midrun
              ? Image.asset('lib/images/dur.png')
              : Image.asset('lib/images/run.png'),
        ),
      );
    }
  }
}
