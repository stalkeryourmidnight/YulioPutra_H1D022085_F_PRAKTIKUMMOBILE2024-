import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;
  const ProdukDetail({super.key, this.produk});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Yulio'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.produk != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProdukCard(),
                  const SizedBox(height: 20.0),
                  Center(child: _tombolHapusEdit()),
                ],
              )
            : const Center(
                child: Text(
                  'Produk tidak ditemukan',
                  style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
                ),
              ),
      ),
    );
  }

  Widget _buildProdukCard() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tombol Edit
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.edit),
          label: const Text("EDIT"),
          onPressed: () {
            if (widget.produk != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(
                    produk: widget.produk!,
                  ),
                ),
              );
            }
          },
        ),
        const SizedBox(width: 16.0),
        // Tombol Hapus
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.delete),
          label: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    if (widget.produk != null) {
      AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          // Tombol hapus
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Ya"),
            onPressed: () {
              ProdukBloc.deleteProduk(id: (widget.produk!.id!)).then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const ProdukPage()),
                    (Route<dynamic> route) => false);
              }, onError: (error) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => const WarningDialog(
                          description: "Hapus gagal, silahkan coba lagi",
                        ));
              });
            },
          ),
          // Tombol batal
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );

      showDialog(builder: (context) => alertDialog, context: context);
    }
  }
}
