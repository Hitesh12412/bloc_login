import 'package:bloc_login/features/screens/animationscreen/animation_screen.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  bool dropDown = false;
  bool showLogo = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => dropDown = true);
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() => showLogo = true);
    });

    Future.delayed(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LottieAnimationScreen(),
        ),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1100),
            curve: Curves.easeOutCubic,
            left: 0,
            right: 0,
            top: dropDown ? size.height * 0.40 : -80,
            child: Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: showLogo ? 0 : 1,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: showLogo ? 1 : 0,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.4, end: showLogo ? 1 : 0.4),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/logo.png',
                      width: 130,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
