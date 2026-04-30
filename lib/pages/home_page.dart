import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/banner_slider.dart';
import '../widgets/group_section.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_drawer.dart';
import '../widgets/search_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _productsToShow = 8; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const CartDrawer(), 
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    title: const Text('Kpop Merch Store', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24)),
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    actions: [
                      // TOMBOL SEARCH MEMANGGIL DRAWER BARU
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.black87),
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
                                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                                onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                              ),
                              if (cartCount > 0)
                                Positioned(
                                  right: 8, top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                    child: Text('$cartCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                  ),
                                ),
                            ],
                          );
                        }
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: const [BannerSlider(), CategoryMenu()],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      const TabBar(
                        labelColor: Colors.black, unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black, indicatorWeight: 3,
                        tabs: [Tab(text: 'NEW'), Tab(text: 'SECOND')],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  _buildMainList(allProducts.where((p) => p.condition == "NEW").toList()),
                  _buildMainList(allProducts.where((p) => p.condition == "SECOND").toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainList(List<Product> tabProducts) {
    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 40),
      children: [
        ...groupList.map((group) {
          final products = tabProducts.where((p) => p.groupName == group).toList();
          return GroupSection(groupName: group, products: products);
        }).toList(),
        
        const Padding(
          padding: EdgeInsets.only(top: 40, bottom: 20, left: 16),
          child: Text('More to explore for you!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.65,
            ),
            itemCount: _productsToShow < tabProducts.length ? _productsToShow : tabProducts.length,
            itemBuilder: (context, index) => ProductCard(product: tabProducts[index]),
          ),
        ),
        
        const SizedBox(height: 30),
        if (_productsToShow < tabProducts.length)
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.pink),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                setState(() { _productsToShow += 8; });
              },
              child: const Text('Load More Products', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }
}

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: ['Categories', 'Brands', 'New Arrivals', 'Best Sellers', 'Gift Card'].map((menu) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text(menu),
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey[200]!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )).toList(),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => Container(color: Colors.white, child: _tabBar);
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}