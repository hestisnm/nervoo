import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/notifikasi.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/screen/splash_screen.dart';

class ProfilGuruPage extends StatefulWidget {
  const ProfilGuruPage({super.key});

  @override
  State<ProfilGuruPage> createState() => _ProfilGuruPageState();
}

class _ProfilGuruPageState extends State<ProfilGuruPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _namaController =
      TextEditingController(text: "Satya");
  final TextEditingController _nipController =
      TextEditingController(text: "1987654321");
  final TextEditingController _mapelController =
      TextEditingController(text: "Informatika");

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
    _nipController.dispose();
    _mapelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Konten utama yang akan mentok di bawah
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 80),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(24, 80, 24, 24),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _inputField(
                                      title: 'Nama Lengkap',
                                      hint: 'Masukkan nama Anda',
                                      controller: _namaController,
                                    ),
                                    const SizedBox(height: 20),
                                    _inputField(
                                      title: 'NIP',
                                      hint: 'Masukkan NIP',
                                      controller: _nipController,
                                    ),
                                    const SizedBox(height: 20),
                                    _inputField(
                                      title: 'Mata Pelajaran',
                                      hint: 'Contoh: Matematika',
                                      controller: _mapelController,
                                    ),
                                    const SizedBox(height: 30),
                                    _teachingActivitySummary(),
                                    const SizedBox(height: 40),
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Data berhasil disimpan!'),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorConstant.primary,
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                              builder: (context) =>
                                                  SplashScreen()),
                                          (route) => false,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                          ),
                        );
                      },
                    ),

                    // Avatar profil
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/bws.png'),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Tambahkan aksi edit jika perlu
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

  Widget _teachingActivitySummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Keaktifan Mengajar',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            Text(
              '76%',
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
            value: 0.6,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            color: ColorConstant.primary,
          ),
        ),
      ],
    );
  }
}
