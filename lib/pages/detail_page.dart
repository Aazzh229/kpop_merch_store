import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/cart_drawer.dart';
import '../widgets/search_drawer.dart';
import 'checkout_page.dart';
class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  String? _selectedVariant;
  final GlobalKey<ScaffoldState> _detailScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;


    return Scaffold(
      key: _detailScaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const CartDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('K-STORE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearchDrawer(context);
            },
          ),
          ListenableBuilder(
            listenable: cartProvider,
            builder: (context, child) {
              int cartCount = cartProvider.totalItems;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    onPressed: () => _detailScaffoldKey.currentState!.openEndDrawer(),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 8, top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text('$cartCount', style: const TextStyle(color: Colors.pink, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ),
                    ),
                ],
              );
            }
          ),
          const SizedBox(width: 10),
        ]
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Home / ${widget.product.groupName} / ${widget.product.name}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 30),
                  
                  isDesktop ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildImageSection()),
                      const SizedBox(width: 50),
                      Expanded(flex: 4, child: _buildDetailsSection(context)),
                    ],
                  ) : Column(
                    children: [
                      _buildImageSection(),
                      const SizedBox(height: 30),
                      _buildDetailsSection(context),
                    ],
                  ),
                  
                  const SizedBox(height: 50),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 30),
                  
                  _buildReviewSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8)),
      child: Image.network(widget.product.imageUrl, fit: BoxFit.contain, height: 500, width: double.infinity, errorBuilder: (c,e,s) => const Icon(Icons.image_not_supported, size: 100, color: Colors.grey)),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.product.groupName.toUpperCase(), style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
        const SizedBox(height: 10),
        Text(widget.product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
        const SizedBox(height: 15),
        
        Row(
          children: [
            Text(widget.product.price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink)),
            const SizedBox(width: 10),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(3)), child: const Text("SALE", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
            if (widget.product.isBestSeller) ...[
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(3)), child: const Text("BEST SELLER", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
            ],
          ],
        ),
        const SizedBox(height: 10),
        
        Row(
          children: [
            Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16))),
            const SizedBox(width: 8),
            const Text("5 reviews", style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 15),
        
        _buildInfoRow("Label", "K-POP ENTERTAINMENT"),
        _buildInfoRow("Artist", widget.product.groupName),
        _buildInfoRow("Release date", "Aug 15th, 2026"),
        const SizedBox(height: 20),

        const Text("Option:", style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 5),
        if (widget.product.variants.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedVariant ?? widget.product.variants.first,
                isExpanded: true,
                items: widget.product.variants.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
                onChanged: (v) {
                  setState(() {
                    _selectedVariant = v;
                  });
                },
              ),
            ),
          ),
        const SizedBox(height: 20),

        const Text("Quantity:", style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 5),
        Container(
          width: 120,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap: () => setState(() { if (quantity > 1) quantity--; }), child: const Padding(padding: EdgeInsets.all(12), child: Icon(Icons.remove, size: 18, color: Colors.black54))),
              Text("$quantity", style: const TextStyle(fontWeight: FontWeight.bold)),
              InkWell(onTap: () => setState(() { quantity++; }), child: const Padding(padding: EdgeInsets.all(12), child: Icon(Icons.add, size: 18, color: Colors.black54))),
            ],
          ),
        ),
        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity, height: 55,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), elevation: 0),
                  onPressed: () {
                    for (int i = 0; i < quantity; i++) {
                      cartProvider.addToCart(widget.product);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product.name} added!'), backgroundColor: Colors.pink));
                  },
                  child: const Text("ADD TO CART", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), elevation: 0),
                  onPressed: () {
                    for (int i = 0; i < quantity; i++) {
                      cartProvider.addToCart(widget.product);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage()));
                  },
                  child: const Text("BUY NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(title, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Customer Reviews", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.9,
          ),
          itemCount: dummyReviews.length,
          itemBuilder: (context, index) {
            final review = dummyReviews[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: List.generate(5, (starIndex) => Icon(starIndex < review.rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 16))),
                  const SizedBox(height: 10),
                  Text(review.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(review.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 10),
                  Expanded(child: Text(review.comment, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.4))),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}