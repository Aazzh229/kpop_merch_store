// ==========================================
// FILE: lib/widgets/search_drawer.dart
// ==========================================
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/detail_page.dart';

void showSearchDrawer(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "SearchDrawer",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const Align(
        alignment: Alignment.centerRight,
        child: Material(
          elevation: 16,
          child: SizedBox(
            width: 400,
            height: double.infinity,
            child: SearchDrawerContent(),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
        child: child,
      );
    },
  );
}

class SearchDrawerContent extends StatefulWidget {
  const SearchDrawerContent({Key? key}) : super(key: key);
  @override
  _SearchDrawerContentState createState() => _SearchDrawerContentState();
}

class _SearchDrawerContentState extends State<SearchDrawerContent> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _results = [];

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() { _results = []; });
      return;
    }
    final q = query.toLowerCase();
    setState(() {
      _results = allProducts.where((p) => p.name.toLowerCase().contains(q) || p.groupName.toLowerCase().contains(q)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Search Input
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black87),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          
          if (_results.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("PRODUCTS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF007A5E), letterSpacing: 1)),
            ),

          // Results List
          Expanded(
            child: _results.isEmpty 
              ? (_searchController.text.isEmpty 
                  ? const Center(child: Text("Type to search products...", style: TextStyle(color: Colors.grey)))
                  : const Center(child: Text("No products found.", style: TextStyle(color: Colors.grey))))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _results.length,
                  separatorBuilder: (c, i) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final product = _results[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context); // Close search drawer
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80, width: 80,
                            decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(4)),
                            child: Image.network(product.imageUrl, fit: BoxFit.contain, errorBuilder: (c,e,s) => const Icon(Icons.image_not_supported)),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.groupName, style: const TextStyle(fontSize: 11, color: Color(0xFF007A5E), fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Text(product.price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Color(0xFF007A5E), size: 18),
                        ],
                      ),
                    );
                  }
                ),
          ),

          // Footer Button
          if (_results.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2FF00), // Kuning Neon seperti di gambar
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    elevation: 0
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("VIEW ALL RESULTS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}