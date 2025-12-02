import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenContent();
}

class _SplashScreenContent extends State<SplashScreen>
    with TickerProviderStateMixin { // 👈 allows multiple animations

  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation (scale)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack, // bounce-like effect
    );

    // Text animation (fade)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Start animations in sequence
    _logoController.forward().then((_) {
      _textController.forward();
    });

    // Navigate after delay
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/onBoarding');
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _logoAnimation,
                child: Image.asset('assets/images/logo.png',),
              ),
              const SizedBox(height: 20),

              FadeTransition(opacity: _textAnimation,child:  const Text(
                'My Shopping App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),)

            ],
          ),
      ),
    );
  }
}
