import 'package:flutter/material.dart';

class Voucher {
  final String code;
  final String title;
  final String description;
  final String type; // 'Discount' or 'Free Shipping'
  final double value;

  Voucher({required this.code, required this.title, required this.description, required this.type, required this.value});
}

class ClaimVoucherPage extends StatefulWidget {
  const ClaimVoucherPage({Key? key}) : super(key: key);

  @override
  State<ClaimVoucherPage> createState() => _ClaimVoucherPageState();
}

class _ClaimVoucherPageState extends State<ClaimVoucherPage> {
  static final List<Voucher> availableVouchers = [
    Voucher(code: 'WELCOME10', title: 'Diskon 10%', description: 'Diskon 10% untuk pesanan pertama Anda', type: 'Discount', value: 0.1),
    Voucher(code: 'FREESHIP', title: 'Gratis Ongkir', description: 'Gratis ongkir ke seluruh Indonesia', type: 'Free Shipping', value: 0),
    Voucher(code: 'KSTORELOVE', title: 'Potongan Rp50rb', description: 'Potongan langsung Rp50.000', type: 'Discount', value: 50000),
  ];

  final Set<String> _claimedVouchers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Klaim Voucher', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: availableVouchers.length,
        itemBuilder: (context, index) {
          final v = availableVouchers[index];
          final isClaimed = _claimedVouchers.contains(v.code);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(color: Colors.pink[50], borderRadius: BorderRadius.circular(8)),
                    child: Icon(v.type == 'Free Shipping' ? Icons.local_shipping : Icons.confirmation_number, color: Colors.pink),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(v.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(v.description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(height: 8),
                        Text('Kode: ${v.code}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 12)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isClaimed 
                      ? null 
                      : () {
                        setState(() {
                          _claimedVouchers.add(v.code);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Voucher ${v.code} diklaim!')));
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isClaimed ? Colors.grey : Colors.pink, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    child: Text(isClaimed ? 'Sudah diklaim' : 'Klaim', style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
