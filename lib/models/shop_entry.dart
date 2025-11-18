// To parse this JSON data, do
//
//     final shopEntry = shopEntryFromJson(jsonString);

import 'dart:convert';

List<ShopEntry> shopEntryFromJson(String str) => List<ShopEntry>.from(json.decode(str).map((x) => ShopEntry.fromJson(x)));

String shopEntryToJson(List<ShopEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopEntry {
    String id;
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;
    int productViews;
    int user;

    ShopEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.productViews,
        required this.user,
    });

    factory ShopEntry.fromJson(Map<String, dynamic> json) => ShopEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        productViews: json["product_views"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "product_views": productViews,
        "user": user,
    };
}
