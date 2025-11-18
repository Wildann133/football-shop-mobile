import 'package:flutter/material.dart';
import 'package:football_shop/models/shop_entry.dart';
import 'package:football_shop/screens/product_detail_page.dart';

class ShopEntryCard extends StatelessWidget {
  final ShopEntry entry;

  const ShopEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        // LEFT: THUMBNAIL
        leading: entry.thumbnail.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  entry.thumbnail,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 30),
              ),

        // TITLE (nama)
        title: Text(
          entry.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // SUBTITLE (harga)
        subtitle: Text(
          "Rp ${entry.price}",
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        trailing: const Icon(Icons.chevron_right),

        // GO TO DETAIL PAGE
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(entry: entry),
            ),
          );
        },
      ),
    );
  }
}
