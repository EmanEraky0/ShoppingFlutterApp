import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context,String title, String body) {
  if (context == null) return;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "CustomDialog",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 250),

    pageBuilder: (_, __, ___) {
      return const SizedBox.shrink(); // required by showGeneralDialog
    },

    transitionBuilder: (_, animation, __, ___) {
      return Transform.scale(
        scale: 0.8 + (0.2 * animation.value), // zoom animation
        child: Opacity(
          opacity: animation.value,           // fade animation
          child: Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 280,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      body,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Text("OK".tr(), style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


