import 'package:flutter/material.dart';
import '../models/product.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
        title: const Text('KPOPMERCH.COM', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop 
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 5, child: _buildLeftForm()),
                Expanded(flex: 4, child: _buildRightSummary()),
              ])
            : SingleChildScrollView(child: Column(children: [_buildRightSummary(), _buildLeftForm()])),
        ),
      ),
    );
  }

  Widget _buildLeftForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Contact", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))),
          const SizedBox(height: 30),
          const Text("Shipping address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: "First name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))))),
              const SizedBox(width: 10),
              Expanded(child: TextField(decoration: InputDecoration(labelText: "Last name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))))),
            ],
          ),
          const SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))),
          const SizedBox(height: 40),
          const Text("Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                const Text("Credit card", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                TextField(decoration: InputDecoration(labelText: "Card number", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: "Expiration date", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))))),
                    const SizedBox(width: 10),
                    Expanded(child: TextField(decoration: InputDecoration(labelText: "Security code", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // TOMBOL PAY NOW (TEMA PINK)
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              onPressed: () {},
              child: const Text("Pay now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSummary() {
    return ListenableBuilder(
      listenable: cartProvider,
      builder: (context, child) {
        return Container(
          color: Colors.pink[50], // LATAR BELAKANG PINK MUDA UNTUK SUMMARY
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                itemCount: cartProvider.items.length, separatorBuilder: (c, i) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item = cartProvider.items[index];
                  return Row(
                    children: [
                      Stack(
                        children: [
                          Container(height: 65, width: 65, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Image.network(item.product.imageUrl)),
                          Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: Text('${item.quantity}', style: const TextStyle(color: Colors.white, fontSize: 10))))
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(child: Text(item.product.name, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.w500))),
                      Text(formatRupiah(item.product.priceValue * item.quantity), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.grey),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("IDR ${formatRupiah(cartProvider.totalPrice)}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              ]),
            ],
          ),
        );
      },
    );
  }
}