import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../cart/presentation/view/cart_screen.dart';
import '../category/presentation/view/category_screen.dart';
import '../favorite/presentation/view/favorite_screen.dart';
import '../home/presentation/view/home_screen.dart';
import '../home/presentation/widgets/build_nav_icon.dart';
import '../profile/presentation/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}


class _MainScreen extends State<MainScreen> {
  int _selectedNavIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, String>> _navItems = [
    {'icon': 'assets/icons/home.png', 'label': 'Home'.tr()},
    {'icon': 'assets/icons/category.png', 'label': 'Category'.tr()},
    {'icon': 'assets/icons/favorite.png', 'label': 'Favorite'.tr()},
    {'icon': 'assets/icons/cart.png', 'label': 'Cart'.tr()},
    {'icon': 'assets/icons/user.png', 'label': 'Profile'.tr()},
  ];
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.cyan[700],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() {
          _selectedNavIndex = index;
        }),
        items: _navItems.map((item) {
          final isSelected = _navItems.indexOf(item) == _selectedNavIndex;
          return BottomNavigationBarItem(
              icon: BuildNavIcon(name: item['icon']!, isSelected: isSelected),
              label: item['label']);
        }).toList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedNavIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
