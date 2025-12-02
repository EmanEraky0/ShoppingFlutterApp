import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 25),
          elevation: 3,
          backgroundColor:color,
          // button color
          foregroundColor: Colors.white,
          // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // curve radius
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        ),
        onPressed:onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
