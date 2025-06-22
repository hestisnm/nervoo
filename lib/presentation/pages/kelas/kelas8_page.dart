import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/notifikasi.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/presentation/pages/mapel_kelas7/senibudaya.dart';

class Kelas8Page extends StatefulWidget {
  const Kelas8Page({super.key});

  @override
  State<Kelas8Page> createState() => _Kelas8PageState();
}

class _Kelas8PageState extends State<Kelas8Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 800), // Lebih cepat biar lompat terasa
    )..repeat(reverse: true); // Animasi bolak-balik (naik turun)

    _bounceAnimation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine, // Efek melompat lembut
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: ColorConstant.primary),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset('assets/images/user_profile.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Selamat Pagi!',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedBuilder(
                          animation: _controller,
                          child: Image.asset(
                            'assets/images/tangan.png',
                            width: 30,
                            height: 30,
                          ),
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: 0.5 *
                                  math.sin(_controller.value * 0.30 * math.pi),
                              child: child,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notifikasi()),
                  );
                },
                color: Colors.black,
                icon: const Icon(Icons.notification_add),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        child: SafeArea(
            child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _userInfo(), // tampilkan user info
          Container(
            height: 120,
            width: 313,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(16), // Jarak isi ke sisi container
            decoration: BoxDecoration(
              color: const Color(0xFFC5BAFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Teks mulai dari atas
              children: [
                // 🔽 Koala melompat-lompat
                AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _bounceAnimation.value),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    "assets/images/study_koala.png",
                  ),
                ),
                const SizedBox(width: 12), // Jarak antara gambar dan teks
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Teks di tengah
                    children: [
                      Text(
                        'Ayo mulai Kerjakan\nkuismu sahabat\nkelas Delapan!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4), // Spasi antara dua teks
                      Text(
                        'Pilihlah Mata Pelajaran Yang Kamu Sukai',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 9,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),

          // Mapel pertama
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/seniBudaya.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'SENI BUDAYA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel kedua
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/garuda_pp.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'PENDIDIKAN\nPANCASILA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ketiga
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/matematika.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'MATEMATIKA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke4
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/ips.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'ILMU PENGETAHUAN\nSOSIAL',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke5
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/ipa.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'ILMU PENGETAHUAN\nALAM',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke6
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/bader.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'BAHASA DAERAH',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke7
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/bAsing.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'BAHASA ASING',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke8
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/agama.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'PENDIDIKAN AGAMA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke9
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/prakarya.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'PRAKARYA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke10
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/infor.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'INFORMATIKA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // mapel ke11
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/bindo.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'BAHASA INDONESIA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // mapel ke12
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 313, // Lebar disamakan dengan container koala
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/PJOK.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'PENDIDIKAN JASMANI,\nOLAHRAGA DAN\nKESEHATAN',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
