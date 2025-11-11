import 'package:flutter/material.dart';
import 'package:football_shop/menu.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    String _description = "";
    String _category = "Peralatan Olahraga"; // default
    String _thumbnail = "";
    bool _isFeatured = false; // default

    final List<String> _categories = [
      'Bola Sepak',
      'Bola Basket',
      'Bola Voli',
      'Bola tenis',
      'Baju Jersey',
      'Peralatan Olahraga',
      'Other',
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Product',
              ),
            ), 
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          drawer: LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                    // === nama ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Masukan Nama Product",
                          labelText: "Nama Product",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _name = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Nama tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Harga Produk ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Masukkan Harga Produk (dalam angka)",
                          labelText: "Harga Produk",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          setState(() {
                            _price = int.tryParse(value ?? "0") ?? 0;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Harga produk tidak boleh kosong!";
                          } else if (int.tryParse(value) == null) {
                            return "Harga harus berupa angka!";
                          } else if (int.parse(value) <= 0) {
                            return "Harga tidak boleh 0 atau negatif!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Deskripsi ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Deskripsi",
                          labelText: "Deskripsi",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Isi Product tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),
                  
                    // === Category ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Kategori",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        value: _category,
                        items: _categories
                            .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(
                                      cat[0].toUpperCase() + cat.substring(1)),
                                ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ),
                  
                    // === Thumbnail URL ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "URL Thumbnail (opsional)",
                          labelText: "URL Thumbnail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _thumbnail = value!;
                          });
                        },
                      ),
                    ),
                  
                    // === Is Featured ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SwitchListTile(
                        title: const Text("Tandai sebagai Product Unggulan"),
                        value: _isFeatured,
                        onChanged: (bool value) {
                          setState(() {
                            _isFeatured = value;
                          });
                        },
                      ),
                    ),

                    // === Tombol Simpan ===
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.indigo),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Produk berhasil tersimpan'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Nama: $_name'),
                                                  Text('Harga: Rp $_price'),
                                                  Text('Deskripsi: $_description'),
                                                  Text('Kategori: $_category'),
                                                  Text('Thumbnail: $_thumbnail'),
                                                  Text(
                                                      'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}')
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  //pindahin resetnya
                                                  _formKey.currentState!.reset();
                                                   setState(() {
                                                  _isFeatured = false;
                                                  _price = 0;
                                                  _category = "Peralatan Olahraga";
                                                  _name = "";
                                                  _description = "";
                                                  _thumbnail = "";
                                                });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    
                                    }
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                      ),
                    ),
                  ],
                    
                ),
          ),
          )
        );

    }
} 