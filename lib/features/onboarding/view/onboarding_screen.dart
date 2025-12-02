import 'package:flutter/material.dart';

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _OnBoardingScreen();
// }
//
// class _OnBoardingScreen extends State<OnBoardingScreen> {
//   final PageController _pageController = PageController();
//   double _currentIndex = 0.0;
//
//   final List<OnBoardingData> listPages = [
//     OnBoardingData(
//         animation: 'assets/images/intro1.jpg',
//         title: 'Welcome Shopping Online',
//         description: 'Experience seamless productivity and organization',
//         bgColor: Colors.cyan.shade700),
//     OnBoardingData(
//         animation: 'assets/images/intro2.jpeg',
//         title: 'Joined',
//         description: 'Join us to add to your cart',
//         bgColor: Colors.cyan.shade800),
//     OnBoardingData(
//         animation: 'assets/images/intro3.jpg',
//         title: 'Enjoy',
//         description: 'Enjoy for easy shopping',
//         bgColor: Colors.cyan.shade900),
//   ];
//
//   void _onNextPressed() {
//     if (_currentIndex < listPages.length - 1) {
//       _pageController.nextPage(
//           duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
//     } else {
//       // Navigate to your login/home screen here
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       setState(() {
//         _currentIndex = _pageController.page!;
//       });
//
//       // 👇 When reaching the last page, trigger auto-navigation
//       if (_pageController.page == listPages.length - 1) {
//         Future.delayed(const Duration(milliseconds: 1000), () {
//           if (mounted) _onNextPressed();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   Widget _buildPage(OnBoardingData page, int index) {
//     double difference = (_currentIndex - index);
//     double scale = 1 - (difference.abs() * 0.1);
//     double opacity = 1 - (difference.abs() * 0.5);
//
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         // 🖼️ Fullscreen background image
//         Transform.scale(
//           scale: scale.clamp(0.9, 1.0),
//           child: Image.asset(
//             page.animation,
//             fit: BoxFit.cover,
//           ),
//         ),
//
//         // 🌓 Overlay gradient for readability
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black.withOpacity(0.6),
//                 Colors.black.withOpacity(0.2),
//               ],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//             ),
//           ),
//         ),
//
//         // 📝 Text content
//         Positioned(
//           bottom: 150,
//           left: 20,
//           right: 20,
//           child: Opacity(
//             opacity: opacity.clamp(0.0, 1.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   page.title,
//                   style: const TextStyle(
//                     fontSize: 28,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   page.description,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildIndicator(int index) {
//     final bool isActive = (index == _currentIndex.round());
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       height: 8,
//       width: isActive ? 22 : 8,
//       decoration: BoxDecoration(
//         color: isActive
//             ? listPages[_currentIndex.round()].bgColor
//             : Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: listPages.length,
//                 itemBuilder: (context, index) {
//                   final page = listPages[index];
//                   return _buildPage(page, index);
//                 },
//               ),
//             ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 listPages.length,
//                 (index) => _buildIndicator(index),
//               ),
//             ),
//             // const SizedBox(height: 30),
//             //
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             //   child:
//             //
//             //   ElevatedButton(
//             //     onPressed: _onNextPressed,
//             //     style: ElevatedButton.styleFrom(
//             //       backgroundColor: Colors.blue,
//             //       foregroundColor: Colors.white,
//             //       minimumSize: const Size(double.infinity, 50),
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(12),
//             //       ),
//             //     ),
//             //     child: Text(
//             //       _currentIndex.round() == listPages.length - 1
//             //           ? 'Get Started'
//             //           : 'Next',
//             //       style: const TextStyle(fontSize: 18),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

class WaveIntroScreen extends StatefulWidget {
  const WaveIntroScreen({super.key});

  @override
  State<WaveIntroScreen> createState() => _WaveIntroScreenState();
}

class _WaveIntroScreenState extends State<WaveIntroScreen> {
  final PageController _pageController = PageController();
  double _currentPage = 0.0;

  final List<_IntroPage> _pages = [
    _IntroPage(
      image: 'assets/images/intro1.jpg',
      title: 'Shop Smart',
      description: 'Find the best deals from your favorite brands.',
    ),
    _IntroPage(
      image: 'assets/images/intro2.png',
      title: 'Fast Delivery',
      description: 'Get your items delivered right to your doorstep.',
    ),
    _IntroPage(
      image: 'assets/images/intro3.jpg',
      title: 'Easy Payments',
      description: 'Multiple payment options for a seamless experience.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });

      // Auto move when last page reached
      if (_pageController.page == _pages.length - 1) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) _goNext();
        });
      }
    });
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPage(_IntroPage page, int index) {
    double delta = (_currentPage - index);
    double scale = (1 - delta.abs() * 0.2).clamp(0.8, 1.0);
    double rotationY = delta * 0.5; // 3D rotation effect
    double opacity = (1 - delta.abs()).clamp(0.0, 1.0);

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateY(rotationY)
        ..scale(scale),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            page.image,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - opacity)), // smooth slide up
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      page.title,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildIndicator(int index) {
    final isActive = index == _currentPage.round();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) => _buildPage(_pages[index], index),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => _buildIndicator(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroPage {
  final String image;
  final String title;
  final String description;

  _IntroPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
