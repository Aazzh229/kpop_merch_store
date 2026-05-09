import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class GroupProductsPage extends StatelessWidget {
  final String groupName;
  const GroupProductsPage({Key? key, required this.groupName}) : super(key: key);

  List<Product> getProductsByGroup(String name) {
    return allProducts.where((p) => p.groupName == name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = getProductsByGroup(groupName);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(groupName, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No products found for $groupName.',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
    );
  }
}
