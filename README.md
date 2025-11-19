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

---

# Tugas 8

## 🔄 Perbedaan Navigator.push() vs Navigator.pushReplacement()

Dalam Flutter, `Navigator` mengelola tumpukan (stack) halaman. Perbedaan utama antara kedua metode ini terletak pada bagaimana mereka berinteraksi dengan stack tersebut:

1. **`Navigator.push()`**

   * **Apa yang dilakukan:** Menambahkan (mendorong) halaman baru ke *atas* tumpukan halaman. Halaman sebelumnya tetap tersimpan di bawahnya.
   * **Implikasi:** Pengguna masih bisa menekan tombol "kembali" (baik secara fisik maupun melalui `AppBar`) untuk kembali ke halaman sebelumnya.
   * **Kapan digunakan di Syball Shop:**
     Metode ini digunakan di `lib/product_card.dart` ketika pengguna menekan tombol **"Tambah Produk"** atau **"Lihat Produk"** pada halaman utama (`menu.dart`).
     Ini memungkinkan pengguna untuk kembali ke halaman utama setelah selesai mengisi form atau melihat daftar produk.

2. **`Navigator.pushReplacement()`**

   * **Apa yang dilakukan:** Mengganti halaman saat ini dengan halaman baru di tumpukan navigasi.
   * **Implikasi:** Halaman sebelumnya dihapus dari tumpukan, sehingga pengguna tidak dapat kembali ke sana dengan tombol "back".
   * **Kapan digunakan di Syball Shop:**
     Metode ini digunakan di `lib/left_drawer.dart`.
     Saat pengguna menavigasi melalui *drawer* (misalnya dari "Halaman Utama" ke "Tambah Produk"), kita tidak ingin menumpuk banyak halaman navigasi.
     Dengan `pushReplacement`, navigasi menjadi lebih bersih dan logis untuk struktur menu samping.

---

## 🏗️ Pemanfaatan Hierarki Widget (Scaffold, Padding, SingleChildScrollView, ListView)

Hierarki widget di aplikasi **Syball Shop** dirancang agar konsisten dan responsif di seluruh halaman:

* **`Scaffold`**
  Berfungsi sebagai struktur dasar setiap halaman (`menu.dart`, `product_form.dart`, `product_list.dart`).
  Menyediakan slot untuk `AppBar`, `Body`, dan `Drawer`.

* **`AppBar`**
  Digunakan di setiap halaman untuk menampilkan judul halaman dengan warna tema biru dan teks putih.
  Tombol hamburger (`Drawer Icon`) otomatis muncul bila halaman memiliki `Drawer`.

* **`Drawer`**
  Ditempatkan di setiap halaman menggunakan widget `LeftDrawer`.
  Ini memastikan pengguna bisa berpindah antarhalaman (Home, Tambah Produk, Daftar Produk) dari mana saja dengan tampilan menu yang konsisten.

* **`Padding`**
  Memberikan jarak antar elemen agar tampilan tidak saling menempel.
  Di `lib/product_form.dart`, setiap `TextFormField` dibungkus dalam `Padding(padding: const EdgeInsets.all(8.0))`.

* **`SingleChildScrollView`**
  Membungkus keseluruhan form di halaman `product_form.dart`.
  Hal ini mencegah error *overflow* ketika konten form lebih tinggi dari layar atau saat keyboard muncul.

* **`ListView`**
  Digunakan di `lib/left_drawer.dart` untuk menyusun menu navigasi (`DrawerHeader`, `ListTile`) secara vertikal dan dapat di-*scroll* bila konten melebihi tinggi layar.

---

## 🎨 Kelebihan Layout Widget pada Form Produk

Struktur layout di `product_form.dart` memanfaatkan kombinasi `Column`, `Padding`, dan `SingleChildScrollView` untuk menciptakan tampilan form yang rapi, adaptif, dan tidak mudah rusak pada berbagai ukuran layar.

* **`Padding`**

  * **Kelebihan:** Menjaga keterbacaan dan estetika dengan memberi ruang antar elemen form.
  * **Contoh:** Setiap `TextFormField` dibungkus `Padding(padding: const EdgeInsets.all(8.0))`.

* **`SingleChildScrollView`**

  * **Kelebihan:** Menghindari *overflow* saat keyboard muncul, karena seluruh form bisa digulir.
  * **Contoh:** Digunakan untuk membungkus seluruh `Column` yang berisi form input di `ProductFormPage`.

* **`SwitchListTile`**

  * **Kelebihan:** Memberikan interaksi boolean dengan tampilan yang mudah dimengerti pengguna.
  * **Contoh:** Digunakan untuk menandai apakah produk adalah **produk unggulan** atau bukan.

---

## 🖌️ Penyesuaian Warna Tema untuk Identitas Visual

Warna tema biru pada **Syball Shop** digunakan secara konsisten untuk memperkuat identitas visual aplikasi.

1. **Definisi Tema:**
   Diatur di `lib/main.dart` menggunakan:

   ```dart
   theme: ThemeData(
     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
   )
   ```
2. **Penggunaan Konsisten:**
   Semua halaman (`menu.dart`, `product_form.dart`, `product_list.dart`) menggunakan warna utama dengan:

   ```dart
   Theme.of(context).colorScheme.primary
   ```
3. **Keuntungan:**
   Jika aplikasi di-*rebrand* (misalnya warna utama diganti menjadi hijau), cukup ubah satu baris warna di `main.dart`.
   Seluruh komponen aplikasi (AppBar, tombol, dll.) akan otomatis menyesuaikan.

---

## 🧩 Fitur yang Telah Diimplementasikan

✅ Halaman Utama (`menu.dart`) dengan identitas mahasiswa dan 3 tombol utama
✅ Drawer navigasi (`left_drawer.dart`) untuk berpindah antarhalaman
✅ Form Tambah Produk (`product_form.dart`) dengan validasi lengkap:

* Nama produk (tidak boleh kosong)
* Harga produk (harus angka dan positif)
* Deskripsi produk
* Dropdown kategori
* URL thumbnail opsional
* Switch produk unggulan
  ✅ Dialog konfirmasi sukses menyimpan data
  ✅ Warna tema konsisten (biru) sesuai panduan

---

# 📘 **Tugas 9**

## 1. Mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON?

Membuat model Dart sangat penting untuk menjaga **konsistensi tipe data**, **keamanan null-safety**, dan **kemudahan maintainability**.
Jika kita langsung memetakan JSON ke `Map<String, dynamic>`, kita kehilangan:

* **Validasi tipe** → Flutter tidak tahu apakah `price` itu int, string, atau null.
* **Null-safety** → bisa menyebabkan runtime error seperti *NoSuchMethodError* ketika akses field yang ternyata null.
* **Maintainability** → sulit mencari error, sulit refactor, dan rawan typo key JSON.
* **IDE Assistance hilang** → tidak ada autocomplete untuk field.

Dengan model, JSON otomatis di-*parse* menjadi objek kuat tipe (`ShopEntry`), sehingga lebih aman dan mudah digunakan.

---

## 2. Apa fungsi package `http` dan `CookieRequest` dalam tugas ini?

**http** → package standar Flutter untuk mengirim request HTTP *tanpa menyimpan cookie*. Biasanya dipakai untuk request API publik atau tanpa login.

**CookieRequest** (dari `pbp_django_auth`) → request HTTP yang **otomatis menyimpan cookie**, termasuk session Django.
Perbedaannya:

| Fitur                  | http    | CookieRequest |
| ---------------------- | ------- | ------------- |
| Menyimpan cookie       | ❌ Tidak | ✅ Ya          |
| Mendukung login Django | ❌ Tidak | ✅ Ya          |
| Otomatis kirim session | ❌ Tidak | ✅ Ya          |
| Cocok untuk tugas PBP  | ❌ Tidak | ⭐ YA          |

Jadi dalam tugas 9, kita *wajib* menggunakan `CookieRequest` supaya login Django dapat dipertahankan di seluruh request.

---

## 3. Mengapa instance `CookieRequest` perlu dibagikan ke semua komponen?

Karena **session login** disimpan di dalam instance `CookieRequest`.
Jika setiap halaman membuat instance baru, maka:

* login tidak tersimpan
* request ke Django tidak membawa cookie
* endpoint yang butuh autentikasi akan gagal

Dengan membagikannya via `Provider`, seluruh halaman Flutter memiliki akses ke **cookie yang sama**, sehingga pengguna tetap login dan dapat mengakses endpoint seperti `/json/` atau `/create-flutter/`.

---

## 4. Jelaskan konfigurasi konektivitas antara Flutter dan Django

Agar Flutter (khususnya di Android / Web) bisa mengakses Django lokal, kita harus melakukan konfigurasi berikut:

### **a. Menambah `10.0.2.2` ke ALLOWED_HOSTS**

Karena emulator Android mengakses host lokal lewat `10.0.2.2`, bukan `127.0.0.1`.
Tanpa ini → Django akan menolak request karena dianggap tidak aman.

### **b. Mengaktifkan CORS & SameSite Cookie**

* CORS memastikan Flutter Web boleh mengakses backend.
* SameSite cookie harus diset `None` supaya cookie bisa terkirim pada cross-site request.
* Tanpa ini login tidak akan tersimpan.

### **c. Mengizinkan akses internet Android**

Di `AndroidManifest.xml` harus ada:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Tanpa ini, seluruh request akan gagal (statusCode 0).

### **Apa yang terjadi jika salah satu konfigurasi tidak dilakukan?**

* Cookie tidak terkirim
* Login gagal / session tidak tersimpan
* Flutter tidak bisa fetch JSON → loading spinner terus
* Error CORS pada Flutter Web
* Error `statusCode: 0` pada emulator Android

---

## 5. Jelaskan mekanisme pengiriman data dari input Flutter hingga tampil di Flutter

Alurnya:

1. **User mengisi form** (nama, harga, kategori, dst.)
2. Flutter kirim data ke Django menggunakan:

   ```dart
   request.postJson("http://127.0.0.1:8000/create-flutter/", jsonEncode({...}))
   ```
3. Django menerima request, memvalidasi data, lalu membuat objek `Shop`.
4. Django mengirimkan JSON response `{ status: "success", id: ... }`.
5. Flutter menerima response → menampilkan snackbar “Produk berhasil ditambahkan”.
6. Flutter membuat request GET ke `/json/`.
7. Django mengirimkan daftar produk dalam JSON.
8. Flutter mem-parse JSON ke model Dart (`ShopEntry.fromJson`).
9. Flutter menampilkan daftar produk (ListView + card).

---

## 6. Jelaskan mekanisme autentikasi login-register-logout

### **Register**

1. Flutter mengirim data:

   ```json
   {"username": "...", "password1": "...", "password2": "..."}
   ```
2. Django memvalidasi → membuat akun → kirim JSON hasil.

### **Login**

1. Flutter mengirim username & password lewat `request.login()`.
2. Django menggunakan `authenticate()` dan `login()`.
3. Django mengirim cookie session.
4. CookieRequest menyimpan session → seluruh halaman “terautentikasi”.

### **Akses halaman lain**

Semua request GET/POST berikutnya mengirim session cookie otomatis.
Django tahu usernya siapa.

### **Logout**

Flutter mengirim POST → Django menjalankan `logout()` → session dihapus.

---

## 7. Implementasi checklist (step-by-step)

Secara singkat, implementasi dilakukan sebagai berikut:

1. **Menambahkan dependency Flutter**

   * `provider`
   * `pbp_django_auth`

2. **Mengaktifkan Internet Permission** (Android) dan CORS (Django)

3. **Menambah Provider untuk CookieRequest**

   ```dart
   return Provider(
     create: (_) => CookieRequest(),
     child: MaterialApp(...),
   );
   ```

4. **Membuat halaman login** menggunakan `request.login()`.

5. **Membuat halaman register** menggunakan `request.postJson()`.

6. **Membuat model Dart** (`ShopEntry`) untuk konversi JSON.

7. **Mengambil data dari Django** lewat `request.get("/json/")`.

8. **Membuat halaman daftar produk** menggunakan `FutureBuilder`.

9. **Membuat form tambah produk** dan mengirim data ke Django.

10. **Menghubungkan seluruh halaman dengan LeftDrawer**.

---

## ✨ Credit

Dibuat oleh **Wildan Muhamad Hafidz - 2406495962 - PBP D**
