import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class NilaiMuridPage extends StatefulWidget {
  @override
  _NilaiMuridPageState createState() => _NilaiMuridPageState();
}

class _NilaiMuridPageState extends State<NilaiMuridPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedKelas;
  final nisController = TextEditingController();
  final namaController = TextEditingController();
  bool _isLoading = false;

  List<Map<String, dynamic>> hasilPencarian = [];
  String filterStatus = 'Semua';
  String cariKuis = "";

  final Map<String, List<Map<String, dynamic>>> dataNilaiMurid = {
    "Kelas 7-12345": [
      {"judul": "Kuis Matematika 1", "status": "Sudah", "nilai": 85},
      {"judul": "Kuis IPA 1", "status": "Sudah", "nilai": 90},
      {"judul": "Kuis Bahasa Indonesia 1", "status": "Belum", "nilai": null},
      {"judul": "Kuis Matematika 2", "status": "Sudah", "nilai": 75},
      {"judul": "Kuis IPA 2", "status": "Belum", "nilai": null},
      {"judul": "Kuis Bahasa Indonesia 2", "status": "Sudah", "nilai": 88},
      {"judul": "Kuis Sejarah 1", "status": "Belum", "nilai": null},
    ],
    "Kelas 8-54321": [
      {"judul": "Kuis Matematika 2", "status": "Sudah", "nilai": 78},
      {"judul": "Kuis IPA 2", "status": "Belum", "nilai": null},
    ],
  };

  Future<void> cariNilai() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      hasilPencarian = [];
      filterStatus = "Semua";
      cariKuis = "";
    });

    await Future.delayed(Duration(seconds: 2));

    String nis = nisController.text.trim();
    String kelas = selectedKelas!;
    String key = "$kelas-$nis";

    if (dataNilaiMurid.containsKey(key)) {
      hasilPencarian = dataNilaiMurid[key]!;
    } else {
      hasilPencarian = [];
    }

    setState(() {
      _isLoading = false;
    });

    if (hasilPencarian.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Data siswa tidak ditemukan atau belum ada kuis.")),
      );
    }
  }

  List<Map<String, dynamic>> get filteredList {
    var list = hasilPencarian;

    if (filterStatus != 'Semua') {
      list = list.where((kuis) => kuis['status'] == filterStatus).toList();
    }

    if (cariKuis.trim().isNotEmpty) {
      list = list
          .where((kuis) => kuis['judul']
              .toString()
              .toLowerCase()
              .contains(cariKuis.toLowerCase()))
          .toList();
    }

    return list;
  }

  double get rataRataNilai {
    var sudah = hasilPencarian
        .where((kuis) => kuis['status'] == 'Sudah' && kuis['nilai'] != null);
    if (sudah.isEmpty) return 0;
    var total = sudah.fold<int>(0, (sum, e) => sum + (e['nilai'] as int));
    return total / sudah.length;
  }

  int get jumlahSudah =>
      hasilPencarian.where((k) => k['status'] == 'Sudah').length;
  int get jumlahBelum =>
      hasilPencarian.where((k) => k['status'] == 'Belum').length;

  @override
  void dispose() {
    nisController.dispose();
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.deepPurple;
    return PageWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               const SizedBox(width: 8),
              Text(
                "Nilai Siswa",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedKelas,
                      decoration: InputDecoration(
                        labelText: "Pilih Kelas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                        prefixIcon: Icon(Icons.class_),
                      ),
                      items: ["Kelas 7", "Kelas 8", "Kelas 9"]
                          .map(
                              (k) => DropdownMenuItem(value: k, child: Text(k)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedKelas = val),
                      validator: (v) => v == null ? "Pilih Kelas" : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nisController,
                      decoration: InputDecoration(
                        labelText: "NIS (Nomor Induk Siswa)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                        prefixIcon: Icon(Icons.confirmation_number_outlined),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            (namaController.text.trim().isEmpty)) {
                          return "Isi NIS atau Nama minimal salah satu";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: "Nama Siswa",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            (nisController.text.trim().isEmpty)) {
                          return "Isi Nama atau NIS minimal salah satu";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : cariNilai,
                        icon: Icon(Icons.search, size: 24),
                        label: Text("Cari Nilai",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 5,
                          shadowColor: themeColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                  ],
                ),
              ),
              if (_isLoading)
                Center(child: CircularProgressIndicator(color: themeColor))
              else if (hasilPencarian.isNotEmpty) ...[
                Card(
                  margin: EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.indigo.shade50,
                  elevation: 6,
                  shadowColor: themeColor.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Ringkasan Performa",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: themeColor)),
                        SizedBox(height: 14),
                        Wrap(
                          spacing: 24,
                          runSpacing: 14,
                          children: [
                            _buildRingkasanItem("Kuis Sudah dikerjakan",
                                jumlahSudah.toString()),
                            _buildRingkasanItem("Kuis Belum dikerjakan",
                                jumlahBelum.toString()),
                            _buildRingkasanItem("Nilai Rata-rata",
                                rataRataNilai.toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5BAFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        value: filterStatus,
                        items: ['Semua', 'Sudah', 'Belum']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              filterStatus = val;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Cari kuis",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Colors.indigo.shade50,
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        onChanged: (val) {
                          setState(() {
                            cariKuis = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final kuis = filteredList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 3,
                      shadowColor: themeColor.withOpacity(0.2),
                      child: ListTile(
                        leading: Icon(
                          kuis['status'] == 'Sudah'
                              ? Icons.check_circle_rounded
                              : Icons.pending_actions_rounded,
                          color: kuis['status'] == 'Sudah'
                              ? Colors.green.shade600
                              : Colors.orange.shade700,
                          size: 28,
                        ),
                        title: Text(kuis['judul'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        subtitle: Text(
                            "Status: ${kuis['status']}\nNilai: ${kuis['nilai'] != null ? kuis['nilai'].toString() : '-'}",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        isThreeLine: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    );
                  },
                ),
                if (filteredList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        "Tidak ada kuis sesuai filter dan pencarian.",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ] else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Center(
                      child: Text("Data belum dicari",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black45))),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRingkasanItem(String title, String value) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade100.withOpacity(0.6),
            offset: Offset(0, 4),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.deepPurple)),
          SizedBox(height: 8),
          Text(title,
              style:
                  GoogleFonts.poppins(fontSize: 14, color: Colors.deepPurple),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
