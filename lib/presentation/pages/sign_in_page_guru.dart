import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/guru/homePageGuru.dart';
import 'package:kelas_pintar/guru/dashboardGuru.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/input_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:gap/gap.dart';

class SignInPageGuru extends StatelessWidget {
  const SignInPageGuru({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double paddingValue = constraints.maxWidth < 400 ? 16 : 25;
          double formPaddingHorizontal = constraints.maxWidth < 400 ? 20 : 54;
          double titleFontSize = constraints.maxWidth < 400 ? 20 : 24;

          return Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _body(formPaddingHorizontal, titleFontSize),
                const Gap(20),
                Text(
                  'Belum punya akun?',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const Gap(5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPageGuru()),
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
          );
        },
      ),
    );
  }

  SingleChildScrollView _body(
      double formPaddingHorizontal, double titleFontSize) {
    return SingleChildScrollView(
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
                horizontal: formPaddingHorizontal, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                const InputWidget(
                  lable: 'NIP',
                ),
                const Gap(15),
                const InputWidget(
                  lable: 'Kode Sekolah',
                ),
                const Gap(25),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Builder(builder: (context) {
                        return ButtonWidget(
                          text: 'Masuk',
                          isFullWidth: true,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Dashboardguru(),
                            ));
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
