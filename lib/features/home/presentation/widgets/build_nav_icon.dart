import 'package:flutter/material.dart';

class BuildNavIcon extends StatelessWidget{
  String name;
  bool isSelected;

  BuildNavIcon({super.key, required this.name , required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.cyan[700] : Colors.grey;

    return Image.asset(
      name,
      color: color,
      height: 24,
      width: 24,
    );
  }
}