import 'package:flutter/material.dart';

class GiftCardCheckoutPage extends StatefulWidget {
  final String amount;
  final Color color;

  const GiftCardCheckoutPage({
    Key? key,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  State<GiftCardCheckoutPage> createState() => _GiftCardCheckoutPageState();
}

class _GiftCardCheckoutPageState extends State<GiftCardCheckoutPage> {
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Gift Card Checkout', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ORDER SUMMARY CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.color, widget.color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: widget.color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('K-STORE', style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12)),
                    const SizedBox(height: 8),
                    const Text('E-Gift Card', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(widget.amount, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('Recipient Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              _buildTextField(label: 'Recipient Name', icon: Icons.person_outline, validatorMsg: 'Please enter recipient name'),
              const SizedBox(height: 12),
              _buildTextField(label: 'Recipient Email', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validatorMsg: 'Please enter recipient email'),
              
              const SizedBox(height: 24),
              const Text('Sender Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              _buildTextField(label: 'Your Name', icon: Icons.person_outline, validatorMsg: 'Please enter your name'),
              const SizedBox(height: 12),
              _buildTextField(label: 'Your Email', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validatorMsg: 'Please enter your email'),
              
              const SizedBox(height: 24),
              const Text('Personal Message (Optional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              _buildTextField(label: 'Add a message...', icon: Icons.message_outlined, maxLines: 3, isRequired: false),

              const SizedBox(height: 24),
              const Text('Voucher', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Masukkan kode voucher',
                      icon: Icons.confirmation_number_outlined,
                      isRequired: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voucher diterapkan!')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Pakai', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
                child: Column(
                  children: [
                    _buildPaymentRadio('Credit/Debit Card', Icons.credit_card),
                    if (_paymentMethod == 'Credit/Debit Card')
                      Padding(
                        padding: const EdgeInsets.only(left: 54, right: 16, bottom: 12),
                        child: Column(
                          children: [
                            _buildTextField(label: 'Card Number', icon: Icons.credit_card, validatorMsg: 'Please enter card number'),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: _buildTextField(label: 'EXP Date', icon: Icons.date_range, validatorMsg: 'Required')),
                                const SizedBox(width: 12),
                                Expanded(child: _buildTextField(label: 'CVV', icon: Icons.lock_outline, validatorMsg: 'Required')),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
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
                          validator: (value) {
                            if (_paymentMethod == 'Bank Transfer / Virtual Account' && value == null) {
                              return 'Please select a bank';
                            }
                            return null;
                          },
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
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
                          validator: (value) {
                            if (_paymentMethod == 'E-Wallet (Gopay/OVO/Dana)' && value == null) {
                              return 'Please select an E-Wallet';
                            }
                            return null;
                          },
                        ),
                      ),
                    const Divider(height: 1),
                    _buildPaymentRadio('QRIS', Icons.qr_code_2),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Payment', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  Text(widget.amount, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink)),
                ],
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process payment
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
                              const Text('The e-gift card has been sent to the recipient\'s email.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildTextField({required String label, required IconData icon, TextInputType keyboardType = TextInputType.text, int maxLines = 1, bool isRequired = true, String? validatorMsg}) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.grey) : Padding(padding: const EdgeInsets.only(bottom: 40), child: Icon(icon, color: Colors.grey)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.pink)),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return validatorMsg ?? 'This field is required';
        }
        return null;
      },
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
}
