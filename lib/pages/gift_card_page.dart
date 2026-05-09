import 'package:flutter/material.dart';
import 'gift_card_checkout_page.dart';

class GiftCardPage extends StatelessWidget {
  const GiftCardPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> giftCards = const [
    {"amount": "Rp 50.000", "color": Colors.pinkAccent},
    {"amount": "Rp 100.000", "color": Colors.purpleAccent},
    {"amount": "Rp 250.000", "color": Colors.blueAccent},
    {"amount": "Rp 500.000", "color": Colors.orangeAccent},
    {"amount": "Rp 1.000.000", "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Gift Cards', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: giftCards.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final card = giftCards[index];
          return Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [card["color"], card["color"].withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: card["color"].withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -30,
                  child: Icon(Icons.card_giftcard, size: 150, color: Colors.white.withOpacity(0.2)),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'K-STORE',
                        style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.w600),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gift Card',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            card["amount"],
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 24,
                  right: 24,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GiftCardCheckoutPage(
                            amount: card["amount"],
                            color: card["color"],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: card["color"],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Buy Now', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
