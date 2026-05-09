import 'package:flutter/material.dart';
import 'category_products_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {"name": "Albums", "icon": Icons.album, "color": Colors.pink},
    {"name": "Photocards", "icon": Icons.photo_library, "color": Colors.purple},
    {"name": "Merchandise", "icon": Icons.star, "color": Colors.blue},
    {"name": "Lightsticks", "icon": Icons.highlight, "color": Colors.yellow},
    {"name": "Apparel", "icon": Icons.checkroom, "color": Colors.orange},
    {"name": "Posters", "icon": Icons.image, "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Categories', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(categoryName: cat["name"]),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: cat["color"].withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cat["color"].withOpacity(0.3), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat["icon"], size: 48, color: cat["color"]),
                  const SizedBox(height: 12),
                  Text(
                    cat["name"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
