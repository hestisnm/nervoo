import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                            angle: 0.5 * math.sin(_controller.value * 0.30 * math.pi),
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
              onPressed: () {},
              color: ColorConstant.primary,
              icon: const Icon(Icons.notification_add),
            ),
          )
        ],
      ),
    );
  }
}
