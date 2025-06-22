import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page_guru.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Pilihan extends StatefulWidget {
  const Pilihan({super.key});

  @override
  State<Pilihan> createState() => _PilihanState();
}

class _PilihanState extends State<Pilihan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PageWidget(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 90),
            child: Center(
              child: Image.asset(
                'assets/images/onboarding2.png',
                width: screenWidth * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(15),
          Text(
            "Latihan soal kapan aja!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const Gap(10),
          Text(
            "Pilih kelas, pilih topik, kerjain soal, dan\ndapatkan koinmu!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                ButtonWidget(
                  text: "DAFTAR",
                  isFullWidth: true,
                  onPressed: () {
                    _showRoleSelectionSheet(context, isDaftar: true);
                  },
                ),
                const SizedBox(height: 12),
                ButtonWidget(
                  text: "MASUK",
                  isFullWidth: true,
                  onPressed: () {
                    _showRoleSelectionSheet(context, isDaftar: false);
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  'Belum punya kode sekolah?',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    final emailController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            "Masukkan Email Sekolah Anda",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          content: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email Sekolah",
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[400]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xFFB9A8FF)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Batal",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCEB9FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              onPressed: () {
                                if (emailController.text.isNotEmpty) {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VerifikasiKodeSekolahPage(
                                              email: emailController.text),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Kirim",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Daftarkan Kode Sekolah',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

  void _showRoleSelectionSheet(BuildContext context, {required bool isDaftar}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  "Belajar bersama, Sukses semua",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Ayo daftarkan dirimu sebagai..",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  text: "Guru",
                  isFullWidth: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => isDaftar
                            ? const SignUpPageGuru()
                            : const SignInPageGuru(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ButtonWidget(
                  text: "Siswa",
                  isFullWidth: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            isDaftar ? const SignUpPage() : const SignInPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VerifikasiKodeSekolahPage extends StatefulWidget {
  const VerifikasiKodeSekolahPage({super.key, required this.email});
  final String email;

  @override
  State<VerifikasiKodeSekolahPage> createState() =>
      _VerifikasiKodeSekolahPageState();
}

class _VerifikasiKodeSekolahPageState
    extends State<VerifikasiKodeSekolahPage> {
  final List<TextEditingController> controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  final String kodeBenar = "12345";

  void _verifikasiKode() {
    String kode = controllers.map((c) => c.text).join();
    if (kode == kodeBenar) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 10),
              Text('Kode Sekolah Aktif!',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kode salah!", style: GoogleFonts.poppins()),
          backgroundColor: Colors.red,
        ),
      );
      for (final controller in controllers) {
        controller.clear();
      }
      focusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2EBFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Masukkan Kode",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text:
                    "Masukkan 5 digit kode yang sudah kami kirimkan ke email ",
                style: GoogleFonts.poppins(fontSize: 14),
                children: [
                  TextSpan(
                    text: widget.email,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return Container(
                  width: 52,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFFB9A8FF), width: 1.5),
                  ),
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: GoogleFonts.poppins(fontSize: 22),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 4) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index - 1]);
                      }
                    },
                    decoration: const InputDecoration(
                        counterText: '', border: InputBorder.none),
                  ),
                );
              }),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: _verifikasiKode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCEB9FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: Text("Verifikasi",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
