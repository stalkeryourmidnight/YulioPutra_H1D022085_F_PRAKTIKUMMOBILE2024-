import 'package:flutter/material.dart';
import 'package:tugas/side_menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Settings'),
      ),
      drawer: const Sidemenu(),  
    );
  }
}
