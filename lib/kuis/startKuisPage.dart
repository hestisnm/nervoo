import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/kuis/senbudKuis.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class StartQuizPage extends StatefulWidget {
  const StartQuizPage({super.key});

  @override
  State<StartQuizPage> createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // animasi naik turun terus-menerus

    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // jangan lupa dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gambar Koala dengan animasi melompat
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/study_koala.png',
              height: 260,
            ),
          ),
          const SizedBox(height: 40),

          // Teks motivasi
          Text(
            'SEMANGAT MENGERJAKAN!',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),

          // Tombol Play
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFD4C6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 36,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
