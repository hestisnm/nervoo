import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/input_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';

class SignUpPageGuru extends StatefulWidget {
  const SignUpPageGuru({super.key});

  @override
  State<SignUpPageGuru> createState() => _SignUpPageGuruState();
}

class _SignUpPageGuruState extends State<SignUpPageGuru> {
  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double paddingValue = constraints.maxWidth < 400 ? 16 : 25;
          double formPaddingHorizontal = constraints.maxWidth < 400 ? 20 : 54;
          double titleFontSize = constraints.maxWidth < 400 ? 20 : 24;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(paddingValue),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Hallo!\nSelamat Datang!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: titleFontSize,
                              ),
                            ),
                          ),
                          const Gap(20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: formPaddingHorizontal,
                              vertical: 30,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                const InputWidget(lable: 'Nama Pengguna'),
                                const Gap(15),
                                const InputWidget(lable: 'NRG'),
                                const Gap(15),
                                const InputWidget(lable: 'Kode Sekolah'),
                                const Gap(25),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: ButtonWidget(
                                        text: 'Daftar',
                                        isFullWidth: true,
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInPageGuru(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      flex: 1,
                                      child: ButtonWidget(
                                        text: 'Batal',
                                        isFullWidth: true,
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => Pilihan(),
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
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Sudah punya akun?',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const Gap(5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPageGuru(),
                        ),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
