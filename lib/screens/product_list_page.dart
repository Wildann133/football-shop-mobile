import 'package:flutter/material.dart';
import 'package:football_shop/models/shop_entry.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/widgets/shop_entry_card.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  Future<List<ShopEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get("http://127.0.0.1:8000/json/");
    return response.map<ShopEntry>((json) => ShopEntry.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Produk')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.data!.isEmpty) return const Center(child: Text("Tidak ada produk."));
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, idx) => ShopEntryCard(entry: snapshot.data![idx]),
          );
        },
      ),
    );
  }
}
