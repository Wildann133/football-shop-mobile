# Football Shop Mobile ⚽️
Tugas Individu PBP Ganjil 25/26  
Wildan Muhammad Hafidz- 2406495962 - PBP D

## Tugas Individu 7
### Apa Itu Widget Tree Pada Flutter?  
Pada Flutter, Widget Tree merupakan representasi logis dari semua widget antarmuka pengguna yang ada di aplikasi. Widget Tree akan dikomputasi selama fase layout (pengukuran dan info struktural) dan akan digunakan selama fase rendering dan hit testing (interaksi dengan sentuhan).
Dalam Widget Tree, setiap node nya adalah widget dan setiap edge (garis penghubung) menggambarkan hubungan Parent dengan Child.

### Bagaimana Hubungan Parent-Child Bekerja Antar Widget
Setiap widget Child harus dideklarasikan di dalam Widget Parent. Widget Parent bertanggung jawab mengatur dan mengelola widget anak yang didefinisikan di dalamnya, meliputi:  
* Komposisi dan Struktur  
Misalnya, widget Column (Parent) menggunakan properti children untuk menampung berbagai widget lain seperti Text, Icon, dan sebagainya.

* Layout  
  * Parent menentukan batasan (Contraints) untuk widget anaknya.  
  * Child menentukan size untuk dirinya sendiri.  
  * Parent menentukan posisi widget anak.  

* Inheritance  
InheritedWidget memungkinkan Parent membagikan data yang dapat diakses oleh widget anak. Sebaliknya, Child juga dapat memicu callback (fungsi yang diberikan oleh Parent) sebagai respon terhadap interaksi pengguna di Child.

* Lifecycle  
Misalnya, saat Parent melakukan rebuild, ia dapat memutuskan apakah Child perlu ikut di-rebuild atau tetap menggunakan state yang ada.

### Widget yang Digunakan Dalam Proyek Ini
* Bawaan Flutter
  * **`Widget`**: abstract class yang diwarisi semua objek yang ditampilkan.
  * **`StatelessWidget`**: membuat widget yang tetap (tidak berubah karena suatu aksi), hanya bergantung pada konfigurasi awal saat ia dibuat.
  * **`MaterialApp`**: wrapper untuk semua Widget yang digunakan dan menyediakan fitur Material Dasar, seperti routing, tema, dan struktur aplikasi. 
  * **`Scaffold`**: menyediakan struktur visual dasar untuk layar, mendefinisikan bagian-bagian umum seperti AppBar (header), body (isi aplikasi), dan Drawer (navigasi di samping).
  * **`Container`**: mengatur dekorasi (warna latar, batas, border radius, bayangan, dll) dan layout (padding, margin, batasan ukuran, dll) untuk widget anaknya.
  * **`Column`**: mengatur daftar widget anak-anaknya secara vertikal, perlu properti children (daftar widget).
  * **`Center`**: memastikan widget anaknya berada di tenagh-tengah ruang yang disediakan untuknya.
  * **`Padding`**: memberi jarak kosong di sekitar widget anaknya, jarak tersebut diatur dengan onjek EdgeInsets.
  * **`SizedBox`**: memberi ruang kosong dengan ukuran tertentu untuk widget anaknya.
  * **`GridView`**: mengatur letak widget anak-anaknya dalam layout dua dimensi.
  * **`AppBar`**: widget yang ada di atas Scaffold, biasanya menampilkan judul halaman dan navbar.
  * **`Text`**: menampilkan teks yang tampilannya bisa diatur lewat properti style yang mengambil objek TextStyle.
  * **`Icon`**: menampilkan ikon yang diambil dari set ikon yang ada (misal dari Material Icons) menggunakan objek IconData.
  * **`Card`**: membuat sebuah Material Design (card) yang sudutnya sedikit bundar, punya elevasi (bayangan ringan), punya efek "mengambang", dan bertugas mengelompokkan konten-konten tertentu.
  * **`InkWell`**: membuat widget anaknya dapat diklik dan memiliki efek ripple (gelombang) khas Material Design saat diesntuh, sehingga widget anaknya jadi lebih interaktif. 
* Hasil Kustom
  * **`MyHomePage`**: menampilkan halaman utama di app
  * **`ItemHomePage`**: menyimpan atribut-atribut dari card dan button yang akan ditampilkan di MyHomePage
  * **`InfoCard`**: membuat card yang akan ditampilkan di MyHomePage
  * **`ItemCard`**: menampilkan button yang dibuat untuk MyHomePage 

### Fungsi Dari Widget MaterialApp dan Alasan Digunakan Sebagai Widget Root

Widget **MaterialApp** adalah widget bawaan Flutter yang berfungsi sebagai pembungkus (wrapper) untuk seluruh widget dalam aplikasi. Widget ini menyediakan fitur-fitur utama dari **Material Design**, seperti sistem navigasi (routing antar halaman), tema, serta struktur dasar aplikasi.

Selain itu, **MaterialApp** sering dijadikan sebagai **widget root** karena melalui widget ini kita dapat mengakses berbagai komponen dan widget bawaan Flutter SDK, seperti `Text`, `DropdownButton`, `AppBar`, `Scaffold`, `ListView`, `StatelessWidget`, `StatefulWidget`, `IconButton`, dan lainnya. Dengan demikian, aplikasi yang dibuat menjadi lebih konsisten, terstruktur, dan memiliki tampilan menarik sesuai standar Material Design.

### Perbedaan StatelessWidget dan StatefulWidget Serta Kapan Harus Memilih yang Mana  
| Perbedaan	 | StatelessWidget	 | StatefulWidget |
| :--- | :--- | :--- |
| Perubahan | Tidak punya variabel internal yang dapat mengubah dirinya (tidak bisa berubah secara mandiri). Perubahan hanya bisa dilakukan jika widget parent-nya di-rebuild dan memberikan data konfigurasi yang berbeda | Bisa berubah secara mandiri melalui `setState()`, bisa berubah juga kalau parent-nya berubah |
| Properti | Semua properti harus `final` (immuteable) | Kelas Widget-nya `final`, tapi kelas `State`-nya punya variabel yang bisa berubah  |
| Lifecycle | Hanya punya satu metode `build()` | Punya beberapa metod lifecycle, seperti `initState()`, `didChangeDependencies()`, `dispose()` untuk mengelola state selama lifetime-nya dia |
| Fungsi | Cocok untuk widget yang tidak berubah-ubah (statis) seperti teks dan ikon | Cocok untuk widget yang interaktif, berubah-ubah, atau perlu diperbarui, seperti form dan checkbox|

### Apa Itu BuildContext, Mengapa Penting di Flutter, dan Bagaimana Penggunaannya di Metode Build

**BuildContext** adalah sebuah *handle* atau referensi yang menunjukkan posisi suatu widget di dalam **widget tree** Flutter. Melalui BuildContext, sebuah widget dapat mengakses sumber daya, data, serta layanan yang diwariskan dari widget lain yang berada di atasnya dalam hierarki.

Beberapa alasan mengapa **BuildContext** sangat penting:

* **Akses Data Turunan (Inherited Data)**
  BuildContext memungkinkan widget untuk mengambil data yang diwariskan dari widget induk yang mungkin jauh di atasnya, seperti `ThemeData` (warna, gaya teks, dll) atau `MediaQueryData` (ukuran layar, orientasi, dll).
* **Interaksi dengan Widget Tingkat Tinggi**
  BuildContext digunakan untuk berinteraksi dengan widget atau layanan tingkat tinggi, seperti `Navigator` (untuk berpindah halaman) atau `ScaffoldMessenger` (untuk menampilkan `Snackbar`).
* **Keterikatan pada Lokasi di Widget Tree**
  Setiap widget memiliki BuildContext yang terikat pada posisinya di widget tree. BuildContext tetap konsisten meskipun widget tersebut di-*rebuild* dengan tipe yang sama, sehingga Flutter dapat menjaga hierarki dan hubungan antar widget dengan benar.

    
Contoh penggunaan BuildContext di method build() di aplikasi ini ada di bagian menu.dart dan main.dart. Di dalam widget MyHomePage (menu.dart), terlihat kita bisa mengambil warna tema aplikasi untuk dipakai sebagai warna latar belakang AppBar, meskipun warna tema aplikasinya ditentukan di file main.dart. Itu terjadi karena parent dari MyHomePage ada di main.dart dan parent tersebut menggunakan build() dengan BuildContext sebagai argumen pertamanya  

### Apa Itu Hot Reload di Flutter dan Bagaimana Bedanya Dengan Hot Restart
* Hot Reload: memuat perubahan kode ke VM, membuat widget tree baru, tapi tetap memertahankan state aplikasi (tidak menjalankan ulang main() atau initState()). Bisa dilakukan dengan menekan Ctrl + F5
* Hot Restart: memuat perubahan kode ke VM dan me-restart aplikasi Flutter, sehingga state aplikasi hilang. Bisa dilakukan dengan menekan Ctrl + Shift + F5
