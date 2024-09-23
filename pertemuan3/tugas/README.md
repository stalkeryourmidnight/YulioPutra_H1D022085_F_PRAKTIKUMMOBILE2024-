# tugas
#main.dart
1. Import Package
Di bagian awal kode, ada import 'package:flutter/material.dart'; yang berarti kita mengimpor pustaka Material dari Flutter. Pustaka ini 
menyediakan berbagai widget dan fungsi yang mengikuti desain Material Design yang sering digunakan untuk membangun UI di aplikasi Flutter.
2. Fungsi main()
Fungsi main() adalah pintu masuk utama dari aplikasi Flutter. Ini adalah fungsi yang pertama kali dijalankan ketika aplikasi dimulai.
Di sini, runApp(const MyApp()) digunakan untuk menjalankan aplikasi dan menampilkan widget MyApp ke layar.
3. Class MyApp
MyApp adalah sebuah class yang merupakan turunan dari StatelessWidget.
Karena ini adalah stateless, artinya widget ini tidak memiliki perubahan status (state) internal yang perlu dikelola. Tampilan aplikasi akan tetap sama selama masa hidup widget ini.
4. Method build()
Method build() bertugas untuk menghasilkan tampilan (UI) aplikasi. Di sini, kita membungkus seluruh UI aplikasi menggunakan MaterialApp.

#side_menu.dart
1. Drawer
Drawer sebuah widget yang menyediakan panel navigasi samping (side menu) yang dapat ditarik keluar dari sisi kiri layar, kemudian Drawer diisi dengan elemen-elemen seperti DrawerHeader dan ListView untuk menampilkan konten di dalamnya.
2. DrawerHeader
DrawerHeader menampilkan bagian atas dari menu samping, berisi informasi tentang profil pengguna.
3. ListView
ListView digunakan sebagai kontainer untuk menampilkan daftar item menu yang dapat di-scroll.
4. ListTile
Setiap ListTile adalah widget berbentuk baris yang terdiri dari ikon dan teks, digunakan untuk navigasi ke halaman lain.
Masing-masing item memiliki ikon yang ditampilkan di sebelah kiri menggunakan widget Icon, contohnya Icons.home_outlined untuk menu Home, dan Icons.info_outline untuk menu About.
Saat pengguna tap pada salah satu item, onTap akan dipanggil dan halaman yang bersangkutan akan terbuka menggunakan Navigator.push.
5. Divider
Setiap item ListTile dipisahkan oleh Divider, sebuah garis horizontal tipis yang memberikan jarak visual antara item-item men
6. Navigasi (Navigator.push)
Navigator.push digunakan untuk berpindah halaman ketika item ListTile diklik.
7. Footer (Logout Button)
Pada bagian bawah menu samping terdapat sebuah tombol logout, yang dibuat menggunakan ElevatedButton.icon. Tombol yang memiliki ikon logout (Icons.logout) di sebelah kiri teks "Logout berfungsi untuk menampilkan opsi keluar dari aplikasi.


#login_page.dart
1. Class LoginPage
LoginPage merupakan sebuah class yang menggunakan StatefulWidget karena ada state yang dapat berubah, seperti input username dan password.
2. Class _LoginPageState
Ini adalah class yang menangani state dari halaman login. Semua logika, UI, dan interaksi ada di sini.
TextEditingController: Ada dua controller, yaitu _usernameController dan _passwordController, yang digunakan untuk mengelola teks yang diinput oleh pengguna di kolom username dan password.
3. Fungsi _saveUsername()
Fungsi ini digunakan untuk menyimpan username yang diinput oleh pengguna menggunakan SharedPreferences, sebuah cara untuk menyimpan data sederhana secara lokal di perangkat.
4. Fungsi _showInput()
Fungsi ini digunakan untuk membuat widget input (kolom teks) yang akan digunakan untuk username dan password.
5. Fungsi _showDialog()
Fungsi ini digunakan untuk menampilkan AlertDialog sebagai umpan balik kepada pengguna ketika login berhasil atau gagal.
6. Widget build()
Di dalam metode build(), struktur UI dari halaman login dibuat:
AppBar: Menampilkan judul aplikasi di bagian atas dengan warna latar belakang teal (biru kehijauan).
Icon: Ikon gembok besar ditampilkan di atas form login untuk memberikan kesan visual keamanan.
Form Input: Dua kolom input, satu untuk username dan satu lagi untuk password, menggunakan fungsi _showInput() yang sudah dijelaskan di atas.
Login Button: Tombol login dibuat menggunakan ElevatedButton yang membentang penuh lebar layar dengan gaya yang modern (warna teal dan sudut membulat).

#home_page.dart
Class _HomePageState
Nama Pengguna: Terdapat variabel String? namauser, yang digunakan untuk menyimpan nama pengguna yang disimpan secara lokal di perangkat.
Method build()
Di dalam method build(),
Scaffold: Scaffold menyediakan kerangka dasar untuk membuat struktur halaman. Ini terdiri dari AppBar, drawer, dan body.
AppBar: Bagian atas halaman yang menampilkan judul 'Home Page'. AppBar memberikan konteks kepada pengguna tentang halaman yang sedang dilihat.
Drawer: Drawer adalah menu samping yang ditampilkan menggunakan widget Sidemenu(). Ini memberikan akses navigasi ke halaman lain di aplikasi (seperti profil, pengaturan, dll.)._loadUsername()
Fungsi ini bertugas mengambil nama pengguna dari SharedPreferences.

#about_page.dart, profile_page.dart, dll
kuranglebihnya sama