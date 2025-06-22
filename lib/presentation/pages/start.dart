import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page_guru.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart'; // import halaman pilihan
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PageWidget(
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 70),
              Center(
                child: Image.asset(
                  'assets/images/masuk.png',
                  width: screenWidth * 0.80,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Belajar bersama,\nsukses semua!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Ayo daftarkan dirimu sebagai...",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    ButtonWidget(
                      text: "MURID",
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ButtonWidget(
                      text: "GURU",
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPageGuru(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tombol kembali (pojok kiri atas)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Pilihan()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
