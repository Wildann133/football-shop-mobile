import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _description = "";
  int _price = 0;
  String _category = "";
  String? _thumbnail = ""; // boleh null
  bool _isFeatured = false;

  // Daftar kategori (contoh — EDIT sesuai Django kamu)
  final List<String> categories = [
    "Ball",
    "Shoes",
    "Jersey",
    "Gloves",
    "Accessories",
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              // Nama Produk
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) =>
                    (value == null || value.isEmpty)
                        ? "Nama tidak boleh kosong"
                        : null,
              ),
              const SizedBox(height: 16),

              // Harga Produk
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(
                    () => _price = int.tryParse(value) ?? 0
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Harga tidak boleh kosong";
                  if (int.tryParse(value) == null) return "Harga harus berupa angka";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Deskripsi
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                onChanged: (value) => setState(() => _description = value),
                validator: (value) =>
                    (value == null || value.isEmpty)
                        ? "Deskripsi tidak boleh kosong"
                        : null,
              ),
              const SizedBox(height: 16),

              // Kategori (Dropdown)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: categories
                    .map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(c),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value ?? ""),
                validator: (value) =>
                    value == null || value.isEmpty
                        ? "Kategori wajib dipilih"
                        : null,
              ),
              const SizedBox(height: 16),

              // Thumbnail (Opsional)
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail (Opsional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) =>
                    setState(() => _thumbnail = value.trim().isEmpty ? null : value),
                // tidak ada validator → opsional
              ),
              const SizedBox(height: 16),

              // Featured Checkbox
              CheckboxListTile(
                title: const Text("Featured Product?"),
                value: _isFeatured,
                onChanged: (val) => setState(() => _isFeatured = val ?? false),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),

                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    final response = await request.postJson(
                      "http://127.0.0.1:8000/create-flutter/",
                      jsonEncode({
                        "name": _name,
                        "price": _price,
                        "description": _description,
                        "category": _category,
                        "thumbnail": _thumbnail ?? "",
                        "is_featured": _isFeatured,
                      }),
                    );

                    if (!mounted) return;

                    if (response["status"] == "success") {
                      // SUCCESS DIALOG
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Berhasil!"),
                          content: const Text("Produk berhasil ditambahkan."),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );

                      // Reset form
                      setState(() {
                        _name = "";
                        _price = 0;
                        _description = "";
                        _category = "";
                        _thumbnail = "";
                        _isFeatured = false;
                      });

                      _formKey.currentState!.reset();

                    } else {
                      // Gagal
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Gagal menyimpan produk: ${response['message']}"),
                        ),
                      );
                    }
                  }
                },

                child: const Text("Simpan Produk", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
