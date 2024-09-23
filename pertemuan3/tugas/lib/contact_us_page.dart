import 'package:flutter/material.dart';
import 'package:tugas/side_menu.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us Page'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Contact Us'),
      ),
      drawer: const Sidemenu(),  
    );
  }
}
