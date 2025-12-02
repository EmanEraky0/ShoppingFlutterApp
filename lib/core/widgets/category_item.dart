import 'package:flutter/material.dart';

import '../../../features/home/domain/entities/category_data.dart';

class CategoryItem extends StatelessWidget {
  CategoryData categoryData;

  CategoryItem({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4))
        ],
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  categoryData.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                categoryData.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              )
            ],
          )),
    );
  }
}
