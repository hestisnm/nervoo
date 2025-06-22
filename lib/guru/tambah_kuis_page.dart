import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class TambahKuisPage extends StatefulWidget {
  @override
  _TambahKuisPageState createState() => _TambahKuisPageState();
}

class _TambahKuisPageState extends State<TambahKuisPage> {
  final _formKey = GlobalKey<FormState>();

  final judulKuisController = TextEditingController();
  final pertanyaanController = TextEditingController();
  final jawabanBenarController = TextEditingController();
  final jawabanSalah1Controller = TextEditingController();
  final jawabanSalah2Controller = TextEditingController();
  final jawabanSalah3Controller = TextEditingController();

  String? selectedKelas;
  String? selectedPelajaran;

  List<Map<String, dynamic>> daftarSoal = [];

  bool _isLoading = false;

  void tambahSoal() {
    final pertanyaan = pertanyaanController.text.trim();
    final jawabanBenar = jawabanBenarController.text.trim();
    final jawabanSalah1 = jawabanSalah1Controller.text.trim();
    final jawabanSalah2 = jawabanSalah2Controller.text.trim();
    final jawabanSalah3 = jawabanSalah3Controller.text.trim();

    if (pertanyaan.isEmpty ||
        jawabanBenar.isEmpty ||
        jawabanSalah1.isEmpty ||
        jawabanSalah2.isEmpty ||
        jawabanSalah3.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lengkapi semua kolom soal terlebih dahulu.")),
      );
      return;
    }

    List<Map<String, dynamic>> jawabanList = [
      {"label": "", "text": jawabanBenar, "isCorrect": true},
      {"label": "", "text": jawabanSalah1, "isCorrect": false},
      {"label": "", "text": jawabanSalah2, "isCorrect": false},
      {"label": "", "text": jawabanSalah3, "isCorrect": false},
    ];

    jawabanList.shuffle(Random());
    final labels = ['A', 'B', 'C', 'D'];
    for (int i = 0; i < 4; i++) {
      jawabanList[i]['label'] = labels[i];
    }

    setState(() {
      daftarSoal.add({
        "pertanyaan": pertanyaan,
        "jawaban": jawabanList,
        "jawabanBenar":
            jawabanList.firstWhere((j) => j['isCorrect'] == true)['label'],
      });

      pertanyaanController.clear();
      jawabanBenarController.clear();
      jawabanSalah1Controller.clear();
      jawabanSalah2Controller.clear();
      jawabanSalah3Controller.clear();
    });
  }

  Widget buildDropdown(String label, List<String> items, String? selectedValue,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.indigo.shade50,
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Pilih $label" : null,
    );
  }

  Future<void> uploadKuis() async {
    // Validasi form dulu
    if (!_formKey.currentState!.validate()) return;

    if (daftarSoal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tambahkan minimal satu soal dulu ya!")),
      );
      return;
    }

    // Tampilkan loading dialog
    setState(() {
      _isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    try {
      // Simulasi delay upload data ke backend
      await Future.delayed(Duration(seconds: 2));

      // Data yang akan dikirim ke backend
      final dataKuis = {
        "judul": judulKuisController.text.trim(),
        "kelas": selectedKelas,
        "pelajaran": selectedPelajaran,
        "soal": daftarSoal,
      };

      // TODO: Ganti dengan API call asli, contoh:
      // await ApiService.uploadKuis(dataKuis);

      // Setelah upload sukses
      Navigator.of(context).pop(); // tutup loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kuis berhasil disimpan!")),
      );

      // Bersihkan form dan soal
      setState(() {
        judulKuisController.clear();
        selectedKelas = null;
        selectedPelajaran = null;
        daftarSoal.clear();
      });
    } catch (e) {
      Navigator.of(context).pop(); // tutup loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan kuis: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    judulKuisController.dispose();
    pertanyaanController.dispose();
    jawabanBenarController.dispose();
    jawabanSalah1Controller.dispose();
    jawabanSalah2Controller.dispose();
    jawabanSalah3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 const SizedBox(width: 8),
                Text(
                  "Tambah Kuis Baru",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: judulKuisController,
                  decoration: InputDecoration(
                    labelText: "Judul Kuis",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.indigo.shade50,
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Isi judul kuis" : null,
                ),
                SizedBox(height: 12),
                buildDropdown(
                    "Kelas",
                    ["Kelas 7", "Kelas 8", "Kelas 9"],
                    selectedKelas,
                    (val) => setState(() => selectedKelas = val)),
                SizedBox(height: 12),
                buildDropdown(
                    "Pelajaran",
                    ["Matematika", "IPA", "Bahasa Indonesia"],
                    selectedPelajaran,
                    (val) => setState(() => selectedPelajaran = val)),
                SizedBox(height: 24),
                Text(
                  "✏️ Tambah Soal",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: pertanyaanController,
                          decoration: InputDecoration(
                            labelText: "Pertanyaan",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.indigo.shade50,
                          ),
                        ),
                        SizedBox(height: 10),
                        ...[
                          jawabanBenarController,
                          jawabanSalah1Controller,
                          jawabanSalah2Controller,
                          jawabanSalah3Controller
                        ].asMap().entries.map((entry) {
                          final controller = entry.value;
                          final label = [
                            "Jawaban Benar",
                            "Jawaban Salah 1",
                            "Jawaban Salah 2",
                            "Jawaban Salah 3"
                          ][entry.key];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: label,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.indigo.shade50,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : tambahSoal,
                          icon: Icon(Icons.add),
                          label: Text("Tambah Soal"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                if (daftarSoal.isNotEmpty) ...[
                  Text(
                    "📄 Daftar Soal",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  ...daftarSoal.map((soal) => Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            soal['pertanyaan'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle:
                              Text("Jawaban Benar: ${soal['jawabanBenar']}"),
                          leading: Icon(Icons.help_outline,
                              color: Colors.deepPurple),
                        ),
                      )),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : uploadKuis,
                    icon: Icon(Icons.save),
                    label: Text("Simpan Kuis"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      textStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
