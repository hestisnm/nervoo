import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/input_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart';
import 'package:gap/gap.dart';

class BuatKodeSekolahPage extends StatelessWidget {
  const BuatKodeSekolahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double paddingValue = constraints.maxWidth < 400 ? 16 : 25;
          double formPaddingHorizontal = constraints.maxWidth < 400 ? 20 : 54;
          double titleFontSize = constraints.maxWidth < 400 ? 20 : 24;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(paddingValue),
              child: _body(formPaddingHorizontal, titleFontSize, context),
            ),
          );
        },
      ),
    );
  }

  Widget _body(double formPaddingHorizontal, double titleFontSize,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Buat Kode Sekolah',
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
          child: Column(
            children: [
              const InputWidget(
                lable: 'Nama Sekolah',
              ),
              const Gap(15),
              const InputWidget(
                lable: 'Alamat Sekolah',
              ),
              const Gap(15),
              const InputWidget(
                lable: 'Nama Pembuat Kode',
              ),
              const Gap(25),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ButtonWidget(
                      text: 'Buat',
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Pilihan(),
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
                            builder: (context) => const Pilihan(),
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
    );
  }
}
