import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true); // loop naik turun

    _bounceAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isSmallScreen = screenWidth < 600;

    return PageWidget(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Efek pantulan
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/happy_koala.png',
                        width: isSmallScreen
                            ? screenWidth * 5
                            : screenWidth * 2, // lebih besar
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        'BELAJAR BERSAMA SUKSES SEMUA',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                      child: Text(
                        'AYO RAIH KOIN EMASMU LAGI!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isSmallScreen ? 14 : 16,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.012),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ButtonWidget(
                            text: "MURID",
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Flexible(
                          child: ButtonWidget(
                            text: "GURU",
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignInPageGuru(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/images/wave.png',
            width: screenWidth,
            height: screenHeight * 0.17,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
