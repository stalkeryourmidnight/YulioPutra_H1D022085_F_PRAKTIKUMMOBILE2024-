# pertemuan7

[Halaman Utama](yulio.png)

Penjelasan
Pertama, buka file HTML dari halaman yang ingin kamu tambahkan komponen. Misalnya, kita gunakan folder_page.html. Di sini, akan menambahkan beberapa elemen seperti header dan card.

Kedua, di dalam <ion-content>, menambahkan komponen yang diinginkan dengan menampilkan informasi nama dan NIM
contoh:
 <ion-card-header>
    <ion-card-title class="card-title">
      <ion-icon name="person-circle-outline" class="icon"></ion-icon>
      Yulio Putra
    </ion-card-title>
    <ion-card-subtitle class="card-subtitle">
      <ion-icon name="school-outline" class="icon"></ion-icon>
      NIM: H1D022085
    </ion-card-subtitle>
  </ion-card-header>
  <ion-card-content>
    <p>As an active 5th semester Informatics student at Jenderal Soedirman University, I have the ambition to be more 
      motivated in trying new activities, thinking critically and solving problems, as well as having good 
      communication and teamwork skills. In my organizational experience, I was able to manage my time by 
      prioritizing and avoiding procrastination, which helped me to finish my work quickly and efficiently. In addition, 
      I have an interest in UI/UX designer</p>
  </ion-card-content>

ketiga, setelah menambahkan komponen, menambahkan tampilan card lebih menarik dengan membuka file SCSS yang sesuai (misalnya folder_page.scss) contoh :
.info-card {
  max-width: 350px;
  margin: 20px auto;
  padding: 16px;
  color: #333;
  background: linear-gradient(to bottom right, #ffffff, #f1f1f1);
  border-radius: 15px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

keempat, menambahkan komponen <ion-icon>
<ion-card-title class="card-title">
      <ion-icon name="person-circle-outline" class="icon"></ion-icon>
      Yulio Putra
    </ion-card-title>
    <ion-card-subtitle class="card-subtitle">
      <ion-icon name="school-outline" class="icon"></ion-icon>
      NIM: H1D022085
    </ion-card-subtitle>

kelima, setelah menambahkan ikon, mempercantik ikon
contoh:
 .icon {
      margin-right: 6px;
      font-size: 20px;
      color: #666;
    }
  
keenam, Setelah semua sudah, jalankan aplikasi dengan perintah berikut di terminal:
ionic serve




