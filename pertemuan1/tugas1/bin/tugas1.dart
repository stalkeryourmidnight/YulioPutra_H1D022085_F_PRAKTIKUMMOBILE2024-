import 'package:tugas1/tugas1.dart' as tugas1;
import 'dart:math';
import 'dart:io';

void main() {
  int batasAtas = 50; 
  int angkaSekarang = 1; 

  print('Permainan Skip Skip!');
  print('Aturannya adalah:');
  print('- Sebutkan angka berurutan.');
  print('- Jika angka tersebut bilangan prima, lewatin bae gausa disebutin.');
  print('- Jika bukan bilangan prima, cetak angkanya.');
  print('\nMulai Permainan:\n');

  while (angkaSekarang <= batasAtas) {
    print('Ayo masukkan angkanya bos:');
    String? input = stdin.readLineSync(); 


    if (input == null || int.tryParse(input) == null) {
      print('Input tidak valid, masukkan angka yang benar.');
      continue;
    }

    int angkaPemain = int.parse(input);
    if (angkaPemain != angkaSekarang) {
      print('Salah! seharusnya menyebutkan angka $angkaSekarang.');
      continue;
    }
    if (isPrime(angkaSekarang)) {
      print('Oops! Angka $angkaSekarang adalah bilangan prima. Seharusnya melewatinya!');
    } else {
      print('Benar! Angka $angkaSekarang adalah bukan bilangan prima.');
    }

   
    angkaSekarang++;
  }

  print('Permainan selesai! kamu telah mencapai batas angka $batasAtas.');
}
bool isPrime(int number) {
  if (number <= 1) return false;
  for (int i = 2; i <= sqrt(number); i++) {
    if (number % i == 0) return false; 
  }
  return true; 
}