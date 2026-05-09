import 'package:flutter/material.dart';
import '../models/product.dart';
import 'checkout_page.dart';

class OrderDetailPage extends StatelessWidget {
  final Product product;
  final String date;
  final String status;
  final String paymentMethod;

  const OrderDetailPage({
    Key? key,
    required this.product,
    required this.date,
    required this.status,
    this.paymentMethod = 'Bank Transfer / Virtual Account (BCA)',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Pembelian', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image and name card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8)),
                      child: Image.network(product.imageUrl, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(product.price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.pink)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              const Text('Informasi Pesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
                child: Column(
                  children: [
                    _buildInfoRow('Tanggal', date),
                    const Divider(height: 24),
                    _buildInfoRow('Status', status, isStatus: true),
                    const Divider(height: 24),
                    _buildInfoRow('Metode Pembayaran', paymentMethod),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              // Action buttons based on status
              if (status == 'Proses')
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pesanan sedang dibatalkan...'), backgroundColor: Colors.red),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('BATALKAN PESANAN', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                  ),
                )
              else if (status == 'Dikirim')
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pesanan telah diterima!'), backgroundColor: Colors.green),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('SUDAH DITERIMA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          side: const BorderSide(color: Colors.orange),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Permintaan pengembalian diajukan'), backgroundColor: Colors.orange),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('AJUKAN PENGEMBALIAN', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {
                      cartProvider.addToCart(product);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage()));
                    },
                    child: const Text('BELI LAGI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isStatus ? FontWeight.bold : FontWeight.w500,
            color: isStatus ? Colors.pink : Colors.black87,
          ),
        ),
      ],
    );
  }
}
