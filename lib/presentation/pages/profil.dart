import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/notifikasi.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/screen/splash_screen.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _namaController =
      TextEditingController(text: "Tutties");
  final TextEditingController _nisController =
      TextEditingController(text: "123456789");

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _namaController.dispose();
    _nisController.dispose();
    super.dispose();
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profil()),
                    );
                  },
                  child: Container(
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
                ),
                const Gap(12),
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
    final screenHeight = MediaQuery.of(context).size.height;

    return PageWidget(
      child: SafeArea(
        child: Column(
          children: [
            _userInfo(),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Konten utama
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      constraints: BoxConstraints(
                        minHeight: screenHeight * 0.75,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _inputField(
                              title: 'Nama Pengguna',
                              hint: 'Masukkan Nama Pengguna',
                              controller: _namaController,
                            ),
                            const SizedBox(height: 20),
                            _inputField(
                              title: 'NIS',
                              hint: 'Masukkan NIS',
                              controller: _nisController,
                            ),
                            const SizedBox(height: 20),
                            _inputField(
                              title: 'Kelas',
                              hint: 'Masukkan Kelas',
                              controller: _nisController,
                            ),
                            const SizedBox(height: 30),
                            _progressBar(value: 0.75),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data berhasil disimpan!'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primary,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'SIMPAN',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'LOGOUT',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),

                    // Avatar profil (bulat di tengah)
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/user_profile.png'),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Tambahkan aksi edit jika diinginkan
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                size: 16,
                                color: ColorConstant.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required String title,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black26),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _progressBar({required double value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress Belajar',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: ColorConstant.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            color: ColorConstant.primary,
          ),
        ),
      ],
    );
  }
}
