import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/core/widgets/category_item.dart';

import '../../domain/entities/category_data.dart';

class CategoryCarousal extends StatelessWidget {
  final List<CategoryData> categories = [
    CategoryData(name: 'Market'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Clothes'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Electronic'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Shoes'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Baby'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Girls'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Boys'.tr(), image: 'assets/images/intro1.jpg'),
  ];

  CategoryCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return CategoryItem(categoryData: category);
        },
      ),
    );
  }
}
