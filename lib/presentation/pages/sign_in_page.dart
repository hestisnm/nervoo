import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/navbar.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/input_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? selectedKelas;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final isSmallHeight = screenHeight < 600;

    return PageWidget(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double paddingValue = constraints.maxWidth < 400 ? 16 : 25;
            double formPaddingHorizontal = constraints.maxWidth < 400 ? 20 : 54;
            double titleFontSize = constraints.maxWidth < 400 ? 20 : 24;

            return Padding(
              padding: EdgeInsets.all(paddingValue),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: mediaQuery.viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(20),
                    Center(
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
                          const InputWidget(lable: 'NIS'),
                          const Gap(15),
                          const InputWidget(lable: 'Kode Sekolah'),
                          const Gap(15),
                          DropdownButtonFormField<String>(
                            value: selectedKelas,
                            hint: const Text('Pilih Kelas'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            items: ['7', '8', '9'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('Kelas $value'),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedKelas = newValue;
                              });
                            },
                          ),
                          const Gap(25),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: ButtonWidget(
                                  text: 'Masuk',
                                  isFullWidth: true,
                                  onPressed: () {
                                    if (selectedKelas == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Silakan pilih kelas terlebih dahulu'),
                                        ),
                                      );
                                      return;
                                    }
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => NavbarSiswa(),
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
                    const Gap(20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Belum punya akun?',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const Gap(5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SignUpPage()),
                              );
                            },
                            child: Text(
                              'Daftar',
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
                    if (isSmallHeight) const Gap(40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
