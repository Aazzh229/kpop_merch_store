import 'package:flutter/material.dart';
import '../models/product.dart';
import 'edit_profile_page.dart';
import 'order_detail_page.dart';
import 'landing_page.dart';

class OrderItem {
  final Product product;
  final String date;
  String status;

  OrderItem({required this.product, required this.date, required this.status});
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // User Data State
  String _userName = 'Ai Nur Azizah';
  String _userEmail = 'ai.nur@example.com';
  String _userPhone = '+62 812 3456 7890';

  // Dummy Orders
  List<OrderItem> myOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Initialize dummy orders
    if (allProducts.isNotEmpty) {
      myOrders = [
        OrderItem(product: allProducts[0], date: '01 Mei 2026', status: 'Proses'),
        OrderItem(product: allProducts[2], date: '30 Apr 2026', status: 'Proses'),
        OrderItem(product: allProducts[1], date: '25 Apr 2026', status: 'Dikirim'),
        OrderItem(product: allProducts[3], date: '24 Apr 2026', status: 'Dikirim'),
        OrderItem(product: allProducts[4], date: '20 Apr 2026', status: 'Selesai'),
        OrderItem(product: allProducts[5], date: '15 Apr 2026', status: 'Pengembalian'),
        OrderItem(product: allProducts[6], date: '10 Apr 2026', status: 'Dibatalkan'),
      ];
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _changeOrderStatus(OrderItem order, String newStatus) {
    setState(() {
      order.status = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status pesanan diperbarui menjadi $newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Keluar Akun?', style: TextStyle(fontWeight: FontWeight.bold)),
                  content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LandingPage()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Ya, Keluar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.pink[100],
                  backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=47'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(_userEmail, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Text(_userPhone, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );

                    if (result != null && result is Map<String, String>) {
                      setState(() {
                        _userName = result['name'] ?? _userName;
                        _userEmail = result['email'] ?? _userEmail;
                        _userPhone = result['phone'] ?? _userPhone;
                      });
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Banner Placeholder for Login/Signup (Visible if guest, but we assume logged in for dummy)
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   color: Colors.yellow[100],
          //   child: const Center(child: Text('Belum masuk? Login atau Sign up sekarang!')),
          // ),

          // TabBar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.pink,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.pink,
              tabs: const [
                Tab(text: 'Proses'),
                Tab(text: 'Dikirim'),
                Tab(text: 'Selesai'),
                Tab(text: 'Pengembalian'),
                Tab(text: 'Dibatalkan'),
              ],
            ),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList('Proses'),
                _buildOrderList('Dikirim'),
                _buildOrderList('Selesai'),
                _buildOrderList('Pengembalian'),
                _buildOrderList('Dibatalkan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(String filterStatus) {
    final filteredOrders = myOrders.where((o) => o.status == filterStatus).toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('Tidak ada pesanan di tab $filterStatus', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderDetailPage(product: order.product, date: order.date, status: order.status)),
              );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text('Belanja • ${order.date}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          order.status,
                          style: const TextStyle(color: Colors.pink, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  
                  // Product Details
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order.product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.image_not_supported, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('1 barang', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Belanja', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text(formatRupiah(order.product.priceValue), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  
                  // Action Buttons based on status
                  if (filterStatus == 'Proses' || filterStatus == 'Dikirim') ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (filterStatus == 'Proses')
                          OutlinedButton(
                            onPressed: () => _changeOrderStatus(order, 'Dibatalkan'),
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                            child: const Text('Batalkan Pesanan'),
                          ),
                        if (filterStatus == 'Dikirim') ...[
                          OutlinedButton(
                            onPressed: () => _changeOrderStatus(order, 'Pengembalian'),
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.orange, side: const BorderSide(color: Colors.orange)),
                            child: const Text('Ajukan Pengembalian'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _changeOrderStatus(order, 'Selesai'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                            child: const Text('Sudah Diterima', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
