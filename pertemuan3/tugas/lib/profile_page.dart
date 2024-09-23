import 'package:flutter/material.dart';
import 'package:tugas/side_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Profile'),
      ),
      drawer: const Sidemenu(),  
    );
  }
}
