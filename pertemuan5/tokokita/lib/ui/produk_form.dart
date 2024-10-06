import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  ProdukForm({super.key, this.produk});

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Produk Yulio";
  String tombolSubmit = "Simpan";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "Ubah Produk Yulio";
        tombolSubmit = "Ubah";
        _kodeProdukTextboxController.text = widget.produk?.kodeProduk ?? '';
        _namaProdukTextboxController.text = widget.produk?.namaProduk ?? '';
        _hargaProdukTextboxController.text = widget.produk?.hargaProduk?.toString() ?? '';
      });
    }
  }

  @override
  void dispose() {
    _kodeProdukTextboxController.dispose();
    _namaProdukTextboxController.dispose();
    _hargaProdukTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _kodeProdukTextField(),
                const SizedBox(height: 20),
                _namaProdukTextField(),
                const SizedBox(height: 20),
                _hargaProdukTextField(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kode Produk",
        labelStyle: const TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Produk",
        labelStyle: const TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        labelStyle: const TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
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
          : Text(
              tombolSubmit,
              style: const TextStyle(fontSize: 18),
            ),
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          if (widget.produk != null) {
            ubah();
          } else {
            simpan();
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage(),
        ),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk?.id);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage(),
        ),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
