# tokokita

[Halaman Login](loginyulio.png)
popup berhasil

[Halaman Registrasi](registrasiyulio.png)

[Popup berhasil](popupregistrasi.png)

[Halaman List Produk](listprodukyulio.png)

[Halaman Detail Produk](detailprodukyulio.png)

[Halaman Tambah Produk](tambahprodukyulio.png)

[Halaman Ubah Produk](ubahprodukyulio.png)


//proses login//
Validasi Data
Penjelasan Kode:
Ketika tombol login ditekan, fungsi _buttonLogin() dipanggil, yang akan melakukan validasi form menggunakan _formKey.
Jika data yang diisi valid (email dan password tidak kosong), fungsi _submit() akan dipanggil untuk memproses login lebih lanjut.
Jika email atau password tidak diisi, akan muncul pesan error di masing-masing field (misal: "Email harus diisi" atau "Password harus diisi").

Proses Login ke API
Langkah:
Fungsi _submit() akan mengumpulkan data email dan password dari form, kemudian mengirimkannya ke API melalui LoginBloc.login().
Dalam login_bloc.dart, fungsi login akan mengirimkan request HTTP POST ke endpoint API (http://localhost:8080/login).
Penjelasan Kode:
API akan mengembalikan response dalam bentuk JSON.
Fungsi LoginBloc.login() akan menerima response dan mengubahnya menjadi model Login.
Jika response.code == 200, itu berarti login berhasil.

Berhasil Login
Langkah:
Jika login berhasil (kode 200), aplikasi akan menyimpan token dan ID pengguna ke dalam UserInfo (shared preferences).
Navigasi: Pengguna akan diarahkan ke halaman ProdukPage (halaman produk) menggunakan Navigator.pushReplacement().
Login Gagal
Langkah:
Jika login gagal (kode selain 200), dialog peringatan ditampilkan menggunakan WarningDialog yang memberikan pesan "Login gagal, silahkan coba lagi".
Pengguna tetap berada di halaman login dan dapat mencoba kembali.

//proses tambah data//
a. Penjelasan:
Proses menambah data produk dilakukan dengan mengirimkan data produk baru ke server melalui metode POST. Data yang dikirim mencakup kode produk, nama produk, dan harga produk. Ketika tombol simpan ditekan, validasi form dilakukan. Jika valid, data akan dikirimkan ke server untuk disimpan.

b. Langkah-langkah:
Pengguna mengisi form produk dengan informasi yang dibutuhkan seperti kode produk, nama produk, dan harga produk.
Saat tombol simpan ditekan, fungsi simpan() dipanggil.
Data produk yang dimasukkan oleh pengguna diambil dari form dan dibuat objek Produk.
Fungsi addProduk dari ProdukBloc dipanggil untuk mengirim data produk baru ke server.
Jika berhasil, pengguna akan diarahkan kembali ke halaman daftar produk. Jika gagal, dialog peringatan akan ditampilkan.

kode
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

//proses read//
a. Penjelasan:
Proses membaca data produk bertujuan untuk mengambil daftar produk dari server menggunakan metode GET. Server akan mengembalikan data dalam bentuk JSON, kemudian diubah menjadi objek Produk yang akan ditampilkan dalam aplikasi.

b. Langkah-langkah:
Fungsi getProduks dipanggil dari ProdukBloc untuk meminta data produk dari server.
Server merespons dengan mengirimkan daftar produk dalam bentuk JSON.
JSON tersebut diubah menjadi daftar objek Produk.
Data produk ditampilkan di halaman daftar produk (ProdukPage).

kode:
static Future<List<Produk>> getProduks() async {
  String apiUrl = ApiUrl.listProduk;
  var response = await Api().get(apiUrl);
  var jsonObj = json.decode(response.body);
  List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
  List<Produk> produks = [];
  for (int i = 0; i < listProduk.length; i++) {
    produks.add(Produk.fromJson(listProduk[i]));
  }
  return produks;
}

//proses update//
Proses mengubah data produk dilakukan dengan mengirimkan data produk yang diperbarui ke server menggunakan metode PUT. Ketika tombol ubah ditekan, data produk yang baru dimasukkan pengguna akan dikirim untuk memperbarui data yang sudah ada.

b. Langkah-langkah:
Pengguna membuka form produk dengan data produk yang ingin diubah sudah terisi.
Pengguna mengubah informasi produk.
Saat tombol ubah ditekan, fungsi ubah() dipanggil.
Data produk yang diperbarui diambil dari form dan dibuat objek Produk.
Fungsi updateProduk dari ProdukBloc dipanggil untuk mengirim data produk yang diperbarui ke server.
Jika berhasil, pengguna diarahkan kembali ke halaman daftar produk. Jika gagal, dialog peringatan ditampilkan.

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


//proses delete//
Proses Menghapus Data Produk (Delete)
a. Penjelasan:
Proses menghapus data produk dilakukan dengan mengirimkan permintaan penghapusan ke server melalui metode DELETE. Produk akan dihapus dari database berdasarkan ID-nya.

b. Langkah-langkah:
Pengguna memilih produk yang ingin dihapus.
Fungsi deleteProduk dari ProdukBloc dipanggil dengan ID produk yang akan dihapus.
Permintaan penghapusan dikirimkan ke server.
Jika berhasil, produk dihapus dari daftar. Jika gagal, dialog peringatan ditampilkan.

kode:
static Future<bool> deleteProduk({int? id}) async {
  String apiUrl = ApiUrl.deleteProduk(id!);
  var response = await Api().delete(apiUrl);
  var jsonObj = json.decode(response.body);
  return (jsonObj as Map<String, dynamic>)['data'];
}


//proses tampil data//
a. Penjelasan:
Proses ini bertujuan untuk menampilkan detail produk yang dipilih oleh pengguna. Data produk diambil dari objek Produk yang dikirimkan sebagai parameter dalam widget ProdukDetail. Data produk seperti kode, nama, dan harga akan ditampilkan di layar dalam bentuk kartu. Selain itu, tombol edit dan hapus juga disediakan untuk memodifikasi atau menghapus produk tersebut.

b. Langkah-langkah:
ProdukDetail menerima objek Produk sebagai parameter.
Data produk diambil dari objek Produk dan ditampilkan dalam tampilan berbentuk kartu menggunakan widget Card.
Tombol "EDIT" dan "DELETE" ditampilkan di bagian bawah kartu.
Tombol "EDIT" akan membawa pengguna ke form edit produk.
Tombol "DELETE" akan memunculkan dialog konfirmasi untuk menghapus produk.

kode:
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

