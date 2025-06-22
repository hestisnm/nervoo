import 'package:flutter/material.dart';

class KelolaKuisPage extends StatelessWidget {
  const KelolaKuisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Kuis'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Text(
          'Di sini guru bisa membuat atau mengedit kuis.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
