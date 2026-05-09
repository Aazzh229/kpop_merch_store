import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class BestSellersPage extends StatelessWidget {
  const BestSellersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Urutkan produk berdasarkan jumlah terjual paling banyak
    final products = List<Product>.from(allProducts)..sort((a, b) => b.soldCount.compareTo(a.soldCount));
    
    // Kita hanya mengambil produk yang laku di atas rata-rata (misal top 20)
    final topProducts = products.take(20).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Best Sellers', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: topProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No best sellers yet.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
                childAspectRatio: 0.58, // Disesuaikan agar muat info terjual
              ),
              itemCount: topProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: topProducts[index]);
              },
            ),
    );
  }
}
