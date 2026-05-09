import 'package:flutter/material.dart';
import '../models/product.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Credit/Debit Card';
  String? _selectedBank;
  String? _selectedEWallet;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan Pembayaran?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Apakah Anda yakin ingin menghentikan proses pembayaran? Data yang sudah diisi akan hilang.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: const Text('Ya, Batalkan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87), 
            onPressed: () async {
              if (await _onWillPop()) {
                if (mounted) Navigator.pop(context);
              }
            }
          ),
          title: const Text('K-STORE', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900)),
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
      ),
    );
  }

  Widget _buildLeftForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Contact", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              validator: (v) => v == null || v.isEmpty ? 'Email tidak boleh kosong' : null,
            ),
            const SizedBox(height: 30),
            const Text("Shipping address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: TextFormField(
                  decoration: InputDecoration(labelText: "First name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                  validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                )),
                const SizedBox(width: 10),
                Expanded(child: TextFormField(
                  decoration: InputDecoration(labelText: "Last name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                  validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                )),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              validator: (v) => v == null || v.isEmpty ? 'Alamat tidak boleh kosong' : null,
            ),
          const SizedBox(height: 40),

          const Text("Voucher", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(hintText: "Masukkan kode voucher", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voucher diterapkan!')));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Pakai", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          const Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
            child: Column(
              children: [
                _buildPaymentRadio('Credit/Debit Card', Icons.credit_card),
                if (_paymentMethod == 'Credit/Debit Card')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(prefixIcon: const Icon(Icons.credit_card, size: 20), labelText: "Card number", isDense: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                            validator: (v) => _paymentMethod == 'Credit/Debit Card' && (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: TextFormField(
                                decoration: InputDecoration(prefixIcon: const Icon(Icons.date_range, size: 20), labelText: "EXP Date", isDense: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                validator: (v) => _paymentMethod == 'Credit/Debit Card' && (v == null || v.isEmpty) ? 'Wajib' : null,
                              )),
                              const SizedBox(width: 12),
                              Expanded(child: TextFormField(
                                decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline, size: 20), labelText: "CVV", isDense: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                validator: (v) => _paymentMethod == 'Credit/Debit Card' && (v == null || v.isEmpty) ? 'Wajib' : null,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                const Divider(height: 1),
                _buildPaymentRadio('Bank Transfer / Virtual Account', Icons.account_balance),
                if (_paymentMethod == 'Bank Transfer / Virtual Account')
                  Padding(
                    padding: const EdgeInsets.only(left: 54, right: 16, bottom: 12),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                      ),
                      hint: const Text('Select Bank', style: TextStyle(fontSize: 14)),
                      value: _selectedBank,
                      items: ['BCA', 'Mandiri', 'BNI', 'BRI', 'BSI', 'CIMB Niaga'].map((bank) {
                        return DropdownMenuItem(value: bank, child: Text(bank, style: const TextStyle(fontSize: 14)));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBank = value;
                        });
                      },
                      validator: (v) => _paymentMethod == 'Bank Transfer / Virtual Account' && v == null ? 'Pilih bank' : null,
                    ),
                  ),
                const Divider(height: 1),
                _buildPaymentRadio('E-Wallet (Gopay/OVO/Dana)', Icons.account_balance_wallet),
                if (_paymentMethod == 'E-Wallet (Gopay/OVO/Dana)')
                  Padding(
                    padding: const EdgeInsets.only(left: 54, right: 16, bottom: 12),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                      ),
                      hint: const Text('Pilih E-Wallet', style: TextStyle(fontSize: 14)),
                      value: _selectedEWallet,
                      items: ['Gopay', 'OVO', 'Dana', 'ShopeePay', 'LinkAja'].map((ewallet) {
                        return DropdownMenuItem(value: ewallet, child: Text(ewallet, style: const TextStyle(fontSize: 14)));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEWallet = value;
                        });
                      },
                      validator: (v) => _paymentMethod == 'E-Wallet (Gopay/OVO/Dana)' && v == null ? 'Pilih E-Wallet' : null,
                    ),
                  ),
                const Divider(height: 1),
                _buildPaymentRadio('QRIS', Icons.qr_code_2),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 80),
                          const SizedBox(height: 16),
                          const Text('Payment Successful!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Your order has been placed successfully.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                cartProvider.items.clear();
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.of(context).pop(); // Close checkout
                              },
                              child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
              child: const Text("Pay now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildPaymentRadio(String title, IconData icon) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      value: title,
      groupValue: _paymentMethod,
      activeColor: Colors.pink,
      onChanged: (value) {
        setState(() {
          _paymentMethod = value!;
        });
      },
    );
  }

  Widget _buildRightSummary() {
    return ListenableBuilder(
      listenable: cartProvider,
      builder: (context, child) {
        return Container(
          color: Colors.pink[50], 
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