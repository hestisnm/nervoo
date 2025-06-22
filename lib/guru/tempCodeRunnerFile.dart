  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:kelas_pintar/guru/lihatEbook.dart';
  import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
  import 'package:kelas_pintar/guru/eboookGuru.dart'; // <-- Tambahkan ini
  import '../constants/color_constant.dart';

  class HomePageGuru extends StatelessWidget {
    const HomePageGuru({super.key});

    @override
    Widget build(BuildContext context) {
      return PageWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Sapaan
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo, Guru Satya! 👋",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Semangat untuk menciptakan generasi emas!",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Info Ringkasan
                Row(
                  children: [
                    _buildInfoCard(
                        "Total Kuis", "12", Icons.assignment, Colors.deepPurple),
                    const SizedBox(width: 12),
                    _buildInfoCard(
                        "Jumlah Siswa", "840", Icons.group, Colors.deepPurple),
                  ],
                ),
                const SizedBox(height: 32),

                // Section: Kuis Terbaru Anda
                _buildSectionHeader("📋 Kuis Terbaru Anda"),
                const SizedBox(height: 10),
                _buildQuizTile("Matematika Dasar", "5 soal | 21 Mei 2024"),
                _buildQuizTile("Bahasa Indonesia", "8 soal | 20 Mei 2024"),
                _buildQuizTile("IPA Kelas 6", "10 soal | 19 Mei 2024"),
                const SizedBox(height: 32),

                // Section: E-book Terbaru Anda
                _buildSectionHeader("📚 E-book Terbaru Anda"),
                const SizedBox(height: 10),
                _buildEbookCard(
                    context,
                    "assets/images/ebook.png",
                    "Pendidikan Pancasila",
                    "Membentuk karakter dan nilai kebangsaan."),
                _buildEbookCard(context, "assets/images/ebook.png",
                    "Matematika Cerdas", "Strategi belajar numerasi efektif."),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildSectionHeader(String title) {
      return Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    }

    Widget _buildInfoCard(
        String title, String count, IconData icon, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.more_horiz, color: Colors.white70, size: 20),
              ),
              const SizedBox(height: 4),
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildQuizTile(String title, String subtitle) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style:
                      GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildEbookCard(
        BuildContext context, String imgPath, String title, String desc) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  Image.asset(imgPath, width: 60, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  Text(desc, style: GoogleFonts.poppins(fontSize: 12)),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuruLiatEbook()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: ColorConstant.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("BACA",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
