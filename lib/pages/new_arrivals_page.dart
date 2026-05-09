import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class NewArrivalsPage extends StatelessWidget {
  const NewArrivalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kita ambil produk dengan kondisi "NEW" dan kita balik urutannya (reversed) 
    // untuk mensimulasikan barang-barang yang paling terakhir ditambahkan (paling baru)
    final products = allProducts.reversed.where((p) => p.condition == "NEW").take(20).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('New Arrivals', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.new_releases_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No new arrivals found.',
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
