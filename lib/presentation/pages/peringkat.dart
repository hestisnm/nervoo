import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/notifikasi.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class PeringkatPage extends StatefulWidget {
  const PeringkatPage({Key? key}) : super(key: key);

  @override
  State<PeringkatPage> createState() => _PeringkatPageState();
}

class _PeringkatPageState extends State<PeringkatPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allRank = [
    {'nama': 'Satya', 'nilai': 1220, 'koin': 8400},
    {'nama': 'Surya', 'nilai': 1210, 'koin': 6600},
    {'nama': 'Peter', 'nilai': 180, 'koin': 6300},
    {'nama': 'Bilqis', 'nilai': 178, 'koin': 54000},
    {'nama': 'Agnes', 'nilai': 175, 'koin': 5300},
  ];

  final Map<String, dynamic> userRank = {
    'ranking': 10,
    'nama': 'Hesti',
    'nilai': 80,
    'koin': 4600,
  };

  late AnimationController _handController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _handController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _handController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: ColorConstant.primary),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.asset('assets/images/user_profile.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
                        animation: _handController,
                        child: Image.asset(
                          'assets/images/tangan.png',
                          width: 30,
                          height: 30,
                        ),
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: 0.5 *
                                math.sin(_handController.value * 2 * math.pi),
                            child: child,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notifikasi()),
                  );
                },
                color: Colors.black,
                icon: const Icon(Icons.notification_add),
              ),
            )
          ],
        ),
      );

  Widget _buildUserRank(Map<String, dynamic> user) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: ColorConstant.primary,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            user['ranking'].toString(),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user['nama'],
          style: GoogleFonts.poppins(),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.score, size: 16),
            const SizedBox(width: 4),
            Text(
              user['nilai'].toString(),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.monetization_on, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              user['koin'].toString(),
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard(int rank, Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: const Color(0xFFE7DBFF),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            '$rank',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          data['nama'],
          style: GoogleFonts.poppins(),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.score, size: 16),
            const SizedBox(width: 4),
            Text(
              '${data['nilai']}',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.monetization_on, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              '${data['koin']}',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRank = allRank
        .asMap()
        .entries
        .where((entry) => entry.value['nama']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .map((entry) => {
              'rank': entry.key + 1,
              'data': entry.value,
            })
        .toList();

    return PageWidget(
      child: Stack(
        children: [
          Column(
            children: [
              _userInfo(),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset(
                  'assets/images/win_koala.png',
                  height: 210,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peringkat Anda",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildUserRank(userRank),
                      const SizedBox(height: 20),
                      Text(
                        "Cari Nama",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Masukkan nama murid...',
                          hintStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        style: GoogleFonts.poppins(),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Peringkat Semua Murid",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: filteredRank.map((item) {
                          final int rank = item['rank'] as int;
                          final Map<String, dynamic> data =
                              item['data'] as Map<String, dynamic>;
                          return _buildRankCard(rank, data);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
