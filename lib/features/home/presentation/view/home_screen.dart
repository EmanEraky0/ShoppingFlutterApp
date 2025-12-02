import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/utils/constants/ui_result.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';
import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';
import '../../../../core/widgets/search_bar.dart';
import '../viewmodel/home_view_model.dart';
import '../widgets/category_carousel.dart';
import '../widgets/product_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var currentIndex = 0;
  final TextEditingController _searchControl = TextEditingController();

  final List<String> slideImg = [
    "https://picsum.photos/400/200",
    "https://picsum.photos/401/200",
    "https://picsum.photos/402/200"
  ];

  Widget _sliderBar() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      items: slideImg.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _searchControl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(title: 'Home'.tr()),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: SearchingBar(
                        searchControl: _searchControl,
                        onChanged: (query) {
                          print('Searching for $query');
                        })),
                _sliderBar(),
                const SizedBox(height: 20),
                _rowTitle('Categories'.tr()),
                CategoryCarousal(),
                _rowTitle('Products'.tr()),
                if (state is Success<List<ProductData>>)
                  ProductCarousel(products: state.data),
              ],
            )),
            if (state is Loading)
              Container(
                color: Colors.grey.withAlpha(128),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        ));
  }

  Widget _rowTitle(String title) {
    return InkWell(
      onTap: () {
        title == "Products".tr()
            ? Navigator.pushNamed(context, '/productsScreen')
            : Navigator.pushNamed(context, '/categoryScreen');
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.cyan[700],
            ),
          )),
    );
  }
}
