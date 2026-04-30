import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_card.dart';

class GroupSection extends StatefulWidget {
  final String groupName;
  final List<Product> products;
  const GroupSection({Key? key, required this.groupName, required this.products}) : super(key: key);

  @override
  _GroupSectionState createState() => _GroupSectionState();
}

class _GroupSectionState extends State<GroupSection> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _totalPages = (widget.products.length / 2.5).ceil();
    if (_totalPages < 1) _totalPages = 1;
    _scrollController.addListener(() {
      if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
        double progress = _scrollController.offset / _scrollController.position.maxScrollExtent;
        int page = (progress * (_totalPages - 1)).round() + 1;
        if (page != _currentPage && page >= 1 && page <= _totalPages) {
          setState(() => _currentPage = page);
        }
      }
    });
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      double target = _scrollController.offset - 300;
      _scrollController.animateTo(target.clamp(0.0, _scrollController.position.maxScrollExtent), duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      double target = _scrollController.offset + 300;
      _scrollController.animateTo(target.clamp(0.0, _scrollController.position.maxScrollExtent), duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Color _getGroupColor(String name) {
    switch (name) {
      case 'BTS': return const Color(0xFF7E30E1);
      case 'SEVENTEEN': return const Color(0xFF00897B);
      case 'TXT': return const Color(0xFFC2185B);
      case 'ENHYPEN': return const Color(0xFF0B5ED7);
      default: return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(color: _getGroupColor(widget.groupName), borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
            child: Row(children: [
              Text(widget.groupName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Icon(Icons.chevron_right, color: Colors.white, size: 20),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.products.length,
              separatorBuilder: (c, i) => const SizedBox(width: 16),
              itemBuilder: (context, index) => ProductCard(product: widget.products[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: _scrollLeft, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey[300]!)), child: const Icon(Icons.chevron_left, color: Colors.grey, size: 18))),
                const SizedBox(width: 16),
                Text('${_currentPage.toString().padLeft(2, '0')}   ${_totalPages.toString().padLeft(2, '0')}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12)),
                const SizedBox(width: 16),
                InkWell(onTap: _scrollRight, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey[300]!)), child: const Icon(Icons.chevron_right, color: Colors.black54, size: 18))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}