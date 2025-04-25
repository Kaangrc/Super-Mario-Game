import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  const Mario({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/duranmario.png'),
    );
  }
}
