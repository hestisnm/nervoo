import 'dart:ui';

import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final Widget child;

  const PageWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEBE8FB),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: -82,
              top: 118,
              child: _bluredCircle(),
            ),
            Positioned(
              left: 367,
              top: 286,
              child: _bluredCircle(),
            ),
            SafeArea(child: child)
          ],
        ));
  }

  Container _bluredCircle() {
    return Container(
      width: 195,
      height: 195,
      decoration: BoxDecoration(
          color: Color.fromARGB(229, 197, 186, 255),
          borderRadius: BorderRadius.circular(195 / 2)),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70), child: Container()),
    );
  }
}
