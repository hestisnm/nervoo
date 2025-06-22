import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/bacaEbook.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/navbar.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Kumpulanebook extends StatefulWidget {
  const Kumpulanebook({super.key});

  @override
  State<Kumpulanebook> createState() => _KumpulanebookState();
}

class _KumpulanebookState extends State<Kumpulanebook> {
  String selectedKelas = 'Semua';

  final List<Map<String, String>> allEbooks = [
    {
      'img': 'assets/images/ebook.png',
      'title': 'Matematika Kelas 7',
      'desc': 'Pelajari dasar-dasar aljabar dan geometri.',
      'kelas': 'Kelas 7',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'IPA Kelas 8',
      'desc': 'Mengenal gaya, energi, dan sistem tubuh manusia.',
      'kelas': 'Kelas 8',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'Bahasa Indonesia Kelas 9',
      'desc': 'Belajar menyusun cerita dan puisi.',
      'kelas': 'Kelas 9',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'Bahasa Inggris Kelas 7',
      'desc': 'Basic grammar and vocabulary for beginners.',
      'kelas': 'Kelas 7',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredEbooks = selectedKelas == 'Semua'
        ? allEbooks
        : allEbooks.where((e) => e['kelas'] == selectedKelas).toList();

    return PageWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: ColorConstant.primary,
            child: Row(
              children: [
                // Tombol kembali
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => NavbarSiswa()),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Baca Ebook',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Dropdown filter kelas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: DropdownButtonFormField<String>(
              value: selectedKelas,
              decoration: InputDecoration(
                labelText: 'Pilih Kelas',
                labelStyle: GoogleFonts.poppins(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: ['Semua', 'Kelas 7', 'Kelas 8', 'Kelas 9']
                  .map((kelas) => DropdownMenuItem(
                        value: kelas,
                        child: Text(kelas, style: GoogleFonts.poppins()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKelas = value!;
                });
              },
            ),
          ),

          // List eBook
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredEbooks.length,
              itemBuilder: (context, index) {
                final ebook = filteredEbooks[index];
                return _buildEbookCard(
                  context,
                  ebook['img']!,
                  ebook['title']!,
                  ebook['desc']!,
                );
              },
            ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imgPath,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.poppins(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EBookReaderScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorConstant.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "BACA",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
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
