import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/constants/color_constant.dart';

class InputWidget extends StatelessWidget {
  final String lable;
  const InputWidget({super.key, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        const Gap(10),
        TextField(
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15),
            decoration: InputDecoration(
                fillColor: const Color(0xFFF6F6F6),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: ColorConstant.primary))),
            cursorColor: const Color(0xFF0D1220)),
        const Gap(20),
      ],
    );
  }
}
