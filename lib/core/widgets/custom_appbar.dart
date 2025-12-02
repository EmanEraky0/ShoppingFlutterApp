import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotifyPressed;

  const CustomAppbar(
      {super.key,
      required this.title,
      this.onBackPressed,
      this.onNotifyPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // if true ,BottomNavigationBar is visible!
    bool isBottomNavVisible = Navigator.canPop(context) == false;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      leading:

      !isBottomNavVisible
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black))
          : null,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // // Image.asset(
          // //   "assets/images/logo.png",
          // //   height: 24,
          // //   width: 24,
          // //   fit: BoxFit.contain,
          // // ),
          // const SizedBox(width: 8),
          Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: onNotifyPressed)
      ],
    );
  }
}
