import 'package:flutter/material.dart';
import 'package:lab5/widgets/custom_loading_indicator.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _bounceAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut, // Smooth bounce effect
    );
    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 247, 116, 197), Color.fromARGB(255, 123, 23, 141)], // Blue to Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with Bounce Animation
              ScaleTransition(
                scale: _bounceAnimation,
                child: Image.asset(
                  'assets/logo.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),

              // Shimmer Effect on "MCA Department"
              Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 12, 2, 2),
                highlightColor: const Color.fromARGB(255, 246, 235, 235)!,
                child: const Text(
                  'MCA Department',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Shimmer Effect on Subtitle
              Shimmer.fromColors(
                baseColor: Colors.white70,
                highlightColor: Colors.purple[200]!,
                child: const Text(
                  'Sardar Patel Institute of Technology',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Custom Loading Animation (Rotating + Pulsating)
              const CustomLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
