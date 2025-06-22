import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
// Import juga file tab lainnya jika sudah ada

class CurvedNavigation extends StatefulWidget {
  const CurvedNavigation({super.key});

  @override
  State<CurvedNavigation> createState() => _CurvedNavigationState();
}

class _CurvedNavigationState extends State<CurvedNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DiscoverPage(), // Ini DiscoverPage kamu yang keren itu
    Center(child: Text('Favorite Page')), // Ganti dengan halaman asli jika ada
    Center(child: Text('Settings Page')), // Ganti dengan halaman asli jika ada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.deepPurple, // Bisa ganti sesuai tema kamu
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
