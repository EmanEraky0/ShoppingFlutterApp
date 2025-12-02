import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/core/widgets/category_item.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';

import '../../../../core/widgets/search_bar.dart';
import '../../../home/domain/entities/category_data.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  final TextEditingController _searchControl = TextEditingController();

  final List<CategoryData> allCategories = [
    CategoryData(name: 'Market'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Clothes'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Electronic'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Shoes'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Baby'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Girls'.tr(), image: 'assets/images/intro1.jpg'),
    CategoryData(name: 'Boys'.tr(), image: 'assets/images/intro1.jpg'),
  ];

  List<CategoryData> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(allCategories); // start with all
  }
  @override
  void dispose() {
   _searchControl.dispose();
    super.dispose();
  }

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = List.from(allCategories);
      } else {
        filteredCategories = allCategories
            .where((cat) =>
            cat.name.toLowerCase().contains(query.toLowerCase().trim()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "All Categories".tr()),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: SearchingBar(
                  searchControl:_searchControl,
                  onChanged: (query) {
                   _filterCategories(query);
                    // print('Searching for $query');
                  })),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(categoryData: filteredCategories[index]);
                }),
          ),
        ],
      ),
    );
  }
}
