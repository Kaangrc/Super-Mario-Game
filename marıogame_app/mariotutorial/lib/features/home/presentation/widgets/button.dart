import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
