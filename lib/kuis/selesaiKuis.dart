import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/navbar.dart';
import 'package:kelas_pintar/presentation/pages/peringkat.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class HasilKuisPage extends StatefulWidget {
  final int nilai;
  final int jawabanBenar;
  final int jawabanSalah;
  final int koinDiperoleh;

  const HasilKuisPage({
    Key? key,
    required this.nilai,
    required this.jawabanBenar,
    required this.jawabanSalah,
    required this.koinDiperoleh,
  }) : super(key: key);

  @override
  State<HasilKuisPage> createState() => _HasilKuisPageState();
}

class _HasilKuisPageState extends State<HasilKuisPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          // Responsive sizes
          final containerWidth = maxWidth * 0.85;
          final trophyHeight = maxHeight * 0.12;
          final paddingHorizontal = maxWidth * 0.04;
          final iconSize = maxWidth * 0.07;
          final fontSizeTitle = maxWidth * 0.055;
          final fontSizeSubtitle = maxWidth * 0.04;
          final fontSizeInfo = maxWidth * 0.035;

          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  numberOfParticles: 30,
                  colors: const [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.purple,
                  ],
                  gravity: 0.2,
                  emissionFrequency: 0.05,
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: maxHeight * 0.08),
                          padding: EdgeInsets.symmetric(
                            vertical: maxHeight * 0.02,
                            horizontal: paddingHorizontal,
                          ),
                          width: containerWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: maxHeight * 0.01),
                              Text(
                                'SELAMAT!',
                                style: TextStyle(
                                  fontSize: fontSizeTitle,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: maxHeight * 0.008),
                              Text(
                                'Kamu mendapatkan nilai ${widget.nilai}',
                                style: TextStyle(
                                  fontSize: fontSizeSubtitle,
                                  fontFamily: 'Poppins',
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: maxHeight * 0.025),
                              const Divider(thickness: 1, color: Colors.grey),
                              SizedBox(height: maxHeight * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInfo(
                                    icon: Icons.monetization_on,
                                    label: '+ ${widget.koinDiperoleh} KOIN',
                                    color: Colors.orange,
                                    iconSize: iconSize,
                                    fontSize: fontSizeInfo,
                                  ),
                                  _buildInfo(
                                    icon: Icons.check_circle,
                                    label: '${widget.jawabanBenar}',
                                    color: Colors.green,
                                    iconSize: iconSize,
                                    fontSize: fontSizeInfo,
                                  ),
                                  _buildInfo(
                                    icon: Icons.cancel,
                                    label: '${widget.jawabanSalah}',
                                    color: Colors.red,
                                    iconSize: iconSize,
                                    fontSize: fontSizeInfo,
                                  ),
                                ],
                              ),
                              SizedBox(height: maxHeight * 0.02),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Image.asset(
                            'assets/images/trophy.png',
                            height: trophyHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: maxHeight * 0.04),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingHorizontal),
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              text: 'Beranda',
                              isFullWidth: true,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => NavbarSiswa(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: maxWidth * 0.04),
                          Expanded(
                            child: ButtonWidget(
                              text: 'Peringkat',
                              isFullWidth: true,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NavbarSiswa(initialIndex: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: maxHeight * 0.04),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfo({
    required IconData icon,
    required String label,
    required Color color,
    required double iconSize,
    required double fontSize,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: iconSize),
        SizedBox(height: fontSize * 0.5),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
