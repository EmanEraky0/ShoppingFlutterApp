import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Profile".tr()),
      body: Column(
        children: [
          // 🌸 Profile Header
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Background image
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/intro2.png"),
                    // replace with your asset
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
              ),

              // Profile image (overlapping)
              Positioned(
                bottom: -40,
                right: MediaQuery.of(context).size.width / 1.3 - 50,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/images/intro2.png"),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          profileInfo("assets/profile/email.png", "emyeraky888@gmail.com"),
          profileInfo("assets/profile/telephone.png",
              "+20 01096516505  +966 546873783"),
          profileInfo("assets/profile/domain.png",
              "https://www.linkedin.com/in/eman-eraky-a13b30148/")
        ],
      ),
    );
  }

  Widget profileInfo(String icon, String Data) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(
            Data,
            style: TextStyle(
                color: Colors.cyan.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ))
        ],
      ),
    );
  }
}
