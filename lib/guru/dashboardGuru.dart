import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/guru/eboookGuru.dart';
import 'package:kelas_pintar/guru/homePageGuru.dart';
import 'package:kelas_pintar/guru/nilai_murid_page.dart';
import 'package:kelas_pintar/guru/profil_guru_page.dart';
import 'package:kelas_pintar/guru/tambah_kuis_page.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas7_page.dart';
import 'package:kelas_pintar/presentation/pages/peringkat.dart';
import 'package:kelas_pintar/presentation/pages/profil.dart';

class Dashboardguru extends StatefulWidget {
  final int initialIndex;
  Dashboardguru({this.initialIndex = 0}); // parameter dengan default 0

  @override
  State<Dashboardguru> createState() => _DashboardguruState();
}

class _DashboardguruState extends State<Dashboardguru> {
  late int _selectedIndex;

 final List<Widget> _pages = [
    HomePageGuru(),
    TambahKuisPage(),
    BacaEbookGuru(),
    NilaiMuridPage(),
    ProfilGuruPage(),
  ];

  final List<Widget> _navItems = [
    Icon(Icons.home, size: 30),
    Icon(Icons.edit, size: 30),
    Icon(Icons.menu_book_outlined, size: 30),
    Icon(Icons.bar_chart, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;  // set dari parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: ColorConstant.primary,
        buttonBackgroundColor: ColorConstant.primary,
        height: 60,
        index: _selectedIndex,
        items: _navItems,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
