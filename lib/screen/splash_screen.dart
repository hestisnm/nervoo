import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_pintar/presentation/pages/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Tunggu 1 detik sebelum animasi fade-in dijalankan
    Future.delayed(const Duration(milliseconds: 2000), () {
      _controller.forward();
    });

    // Setelah total 3 detik, lanjut ke halaman onboarding
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8FB),
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Center(
          child: Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
