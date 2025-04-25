import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  const JumpingMario({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/atlayan.png'),
    );
  }
}
