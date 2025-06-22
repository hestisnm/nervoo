import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Atur padding horizontal menyesuaikan lebar tombol
        double horizontalPadding = 45;
        if (constraints.maxWidth < 200) {
          horizontalPadding = 15;
        } else if (constraints.maxWidth < 300) {
          horizontalPadding = 25;
        }

        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor ?? ColorConstant.primary,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 14,
              ),
              minimumSize: const Size(double.infinity, 48), // minimal tinggi tombol
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: ColorConstant.primary,
                  width: 2,
                ),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown, // Supaya teks tetap muat dan tidak overflow
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
