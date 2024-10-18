import 'package:flutter/material.dart';
import 'package:responsi1/helpers/user_info.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/medicine_screen.dart';
// Import halaman MedicineScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator(); // Tampilan loading saat memeriksa status login

  @override
  void initState() {
    super.initState();
    isLogin(); // Memeriksa status login
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    // Jika token tidak null, berarti sudah login
    if (token != null) {
      setState(() {
        page =  MedicineScreen(); // Arahkan ke halaman MedicineScreen jika sudah login
      });
    } else {
      setState(() {
        page = const LoginPage(); // Jika belum login, arahkan ke halaman login
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi 1',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: page), // Tampilkan halaman berdasarkan status login
      ),
    );
  }
}
