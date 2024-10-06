import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login Yulio'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogo(),
                const SizedBox(height: 40),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 40),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat logo atau header visual di bagian atas
  Widget _buildLogo() {
    return Column(
      children: const [
        Icon(
          Icons.login_rounded,
          size: 100,
          color: Colors.teal,
        ),
        SizedBox(height: 20),
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }

  // Membuat Textbox email dengan desain lebih modern
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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

  // Membuat Textbox password dengan desain lebih modern
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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

  // Membuat Tombol Login dengan desain lebih bersih dan jelas
  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.teal,
      ),
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) {
          _submit();
        }
      },
    );
  }

  // Fungsi submit login
  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProdukPage()));
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Belum punya akun? Registrasi",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
