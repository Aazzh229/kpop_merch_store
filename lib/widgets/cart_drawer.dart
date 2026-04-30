import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/checkout_page.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cartProvider,
      builder: (context, child) {
        final cart = cartProvider.items;
        String totalFormatted = formatRupiah(cartProvider.totalPrice);

        return Drawer(
          width: 400, 
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 10, bottom: 20),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined, color: Colors.black87),
                    const SizedBox(width: 10),
                    Text("${cartProvider.totalItems} item", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink)), // TEMA PINK
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.grey),

              Expanded(
                child: cart.isEmpty
                    ? const Center(child: Text("Your cart is empty", style: TextStyle(color: Colors.grey)))
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: cart.length,
                        separatorBuilder: (c, i) => const Divider(height: 40, color: Colors.black12),
                        itemBuilder: (context, index) {
                          final item = cart[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80, width: 80,
                                decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(4)),
                                child: Image.network(item.product.imageUrl, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported)),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.groupName, style: const TextStyle(fontSize: 11, color: Colors.pink, fontWeight: FontWeight.bold)), // TEMA PINK
                                    const SizedBox(height: 4),
                                    Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    const Text("Option: RANDOM", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    const SizedBox(height: 12),
                                    
                                    Container(
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => cartProvider.updateQuantity(item.product.id, -1),
                                            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: Icon(Icons.remove, size: 16, color: Colors.black87)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          ),
                                          InkWell( // INI YANG DIPERBAIKI (Sebelumnya InkLine)
                                            onTap: () => cartProvider.updateQuantity(item.product.id, 1),
                                            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: Icon(Icons.add, size: 16, color: Colors.black87)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => cartProvider.updateQuantity(item.product.id, -item.quantity), 
                                      child: const Text("Remove", style: TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline)),
                                    )
                                  ],
                                ),
                              ),
                              Text(formatRupiah(item.product.priceValue * item.quantity), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink)), // TEMA PINK
                            ],
                          );
                        },
                      ),
              ),

              // FOOTER CHECKOUT (TEMA PINK)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey[200]!))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Add order note", style: TextStyle(color: Colors.pink, decoration: TextDecoration.underline, fontSize: 13)), // TEMA PINK
                    const SizedBox(height: 5),
                    const Text("* Customs duties are the responsibility of the customer.", style: TextStyle(color: Colors.black54, fontSize: 12)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity, height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // TEMA PINK
                          foregroundColor: Colors.white, // TEKS PUTIH
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), 
                          elevation: 0
                        ),
                        onPressed: cart.isEmpty ? null : () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
                        },
                        child: Text("CHECKOUT  •  $totalFormatted IDR", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}