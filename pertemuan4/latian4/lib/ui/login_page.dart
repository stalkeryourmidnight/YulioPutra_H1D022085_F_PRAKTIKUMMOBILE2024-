import 'package:flutter/material.dart';
import 'package:latian4/ui/registrasi_page.dart';
import 'package:latian4/ui/produk_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  void dispose() {
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Yulio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(
                  height: 30,
                ),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Login dengan logika loading
  Widget _buttonLogin() {
  return _isLoading
      ? const CircularProgressIndicator() // Menampilkan loading jika _isLoading true
      : ElevatedButton(
          child: const Text("Login"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                _isLoading = true; // Menggunakan variabel _isLoading untuk logika loading
              });

              // Contoh logika login (misal delay 2 detik sebagai simulasi proses login)
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  _isLoading = false;
                });
                
                // Setelah login sukses, arahkan ke halaman produk_page.dart
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProdukPage()), // Direct ke halaman ProdukPage
                );

                // Menampilkan notifikasi login berhasil
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login berhasil')),
                );
              });
            }
          },
        );
}

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
