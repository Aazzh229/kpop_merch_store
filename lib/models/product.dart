import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final double priceValue;
  final String imageUrl;
  final String groupName;
  final String condition;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.priceValue,
    required this.imageUrl,
    required this.groupName,
    required this.condition,
    this.description = "Official merchandise imported directly from South Korea. 100% authentic, high quality, and limited edition.",
  });
}

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class ProductReview {
  final String userName;
  final String userImageUrl;
  final double rating;
  final String comment;
  final String date;

  ProductReview({required this.userName, required this.userImageUrl, required this.rating, required this.comment, required this.date});
}

String formatRupiah(double amount) {
  String price = amount.toStringAsFixed(0);
  String result = '';
  int count = 0;
  for (int i = price.length - 1; i >= 0; i--) {
    if (count == 3) {
      result = '.$result';
      count = 0;
    }
    result = price[i] + result;
    count++;
  }
  return 'Rp$result';
}

// STATE MANAGEMENT KERANJANG BAWAAN FLUTTER
class CartProvider extends ChangeNotifier {
  List<CartItem> items = [];

  void addToCart(Product product) {
    int index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(CartItem(product: product));
    }
    notifyListeners(); // Memperbarui layar otomatis
  }

  void updateQuantity(String productId, int delta) {
    int index = items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      items[index].quantity += delta;
      if (items[index].quantity <= 0) {
        items.removeAt(index);
      }
      notifyListeners(); // Memperbarui layar otomatis
    }
  }

  double get totalPrice => items.fold(0, (sum, item) => sum + (item.product.priceValue * item.quantity));
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

// Global state untuk keranjang belanja
final cartProvider = CartProvider();

const String proxy = "https://wsrv.nl/?url=";

final List<ProductReview> dummyReviews = [
  ProductReview(userName: "Asyifa Azsma", userImageUrl: "${proxy}https://randomuser.me/api/portraits/women/44.jpg", rating: 5.0, comment: "Barangnya original! Packing amannn banget, dapet freebies juga. Gomawo seller!", date: "12 Oct 2025"),
  ProductReview(userName: "Budi Santoso", userImageUrl: "${proxy}https://randomuser.me/api/portraits/men/32.jpg", rating: 4.0, comment: "Pengiriman agak lama, tapi barangnya oke banget. Gak nyesel beli di sini.", date: "10 Oct 2025"),
  ProductReview(userName: "Nisa Fitri", userImageUrl: "${proxy}https://randomuser.me/api/portraits/women/68.jpg", rating: 5.0, comment: "Berfungsi normal, mulus banget tanpa cacat!", date: "05 Oct 2025"),
];

final List<Product> allProducts = [
  Product(id: "bts_n1", name: "boneka bt21", price: "Rp250.000", priceValue: 250000, imageUrl: "${proxy}https://i.pinimg.com/1200x/b7/3f/74/b73f749a94cefa2e1ee51259695654d6.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n2", name: "Funko Pop Bts-butter Rm,jin,suga ,j Hope Jimin, V & Jung Kook Figures 7 Pack Set", price: "Rp400.000", priceValue: 400000, imageUrl: "${proxy}https://i.pinimg.com/1200x/29/8a/5c/298a5cd2647ee45d4fa13ad96bc9f95a.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n3", name: "BTS Army Bomb 4 Cradle VER.4 BTS ARMY Light Stick Official K-Pop", price: "Rp850.000", priceValue: 850000, imageUrl: "${proxy}https://i.ebayimg.com/images/g/P88AAeSwPY9p2W4h/s-l1600.webp", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n4", name: "camisa jersey — bts (arirang)", price: "Rp450.000", priceValue: 450000, imageUrl: "${proxy}https://i.pinimg.com/736x/23/6a/33/236a332388d5da9dd51524a04afe2f19.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n5", name: "BTS Arirang World Tour Baseball Jersey", price: "Rp500.000", priceValue: 500000, imageUrl: "${proxy}https://i.etsystatic.com/64439036/r/il/68e06f/7912308947/il_1588xN.7912308947_jmuu.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n6", name: "BTS Anthology Album \"Proof\" - Standard Edition", price: "Rp350.000", priceValue: 350000, imageUrl: "${proxy}https://i.pinimg.com/1200x/fb/d4/a6/fbd4a631113fb673921129875f057232.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n7", name: "Bts Other | Big Hit Entertainment Bts - Butter Album (Peaches Ver.) | Color: Orange | Size: Os", price: "Rp300.000", priceValue: 300000, imageUrl: "${proxy}https://i.pinimg.com/736x/6d/b7/f4/6db7f4c106dfc9a6375aa2a0bfbaa027.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n8", name: "BTS - PERMISSION TO DANCE ON STAGE - LIVE (Target Exclusive, CD)", price: "Rp400.000", priceValue: 400000, imageUrl: "${proxy}https://i.pinimg.com/1200x/be/8a/ea/be8aeaeb8ffa04d9824358d4902123d8.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_n9", name: "BTS Álbum - MAP OF THE SOUL: 7 (Versión 01)", price: "Rp350.000", priceValue: 350000, imageUrl: "${proxy}https://i.pinimg.com/736x/99/e0/fb/99e0fbd33fa7a32cd2d0a6a357ff69ef.jpg", groupName: "BTS", condition: "NEW"),
  Product(id: "bts_s1", name: "lightstick bts", price: "Rp700.000", priceValue: 700000, imageUrl: "${proxy}https://i.pinimg.com/736x/9e/d8/52/9ed8520fd7a2032785f8b482ac805261.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s2", name: "Funko pop bts- jungkook/jimin", price: "Rp150.000", priceValue: 150000, imageUrl: "${proxy}https://i.pinimg.com/736x/03/76/9f/03769f8b8804328a2820f83d57f8f595.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s3", name: "BTS Kpop album Map of the Soul Persona Unsealed No Photo Card", price: "Rp250.000", priceValue: 250000, imageUrl: "${proxy}https://i.pinimg.com/1200x/99/ee/f7/99eef7983144259ae2829ae114b7642f.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s4", name: "BTS Álbum - MAP OF THE SOUL: 7", price: "Rp280.000", priceValue: 280000, imageUrl: "${proxy}https://i.pinimg.com/736x/33/eb/f5/33ebf5c580354dfae7bbc3e204fbf46c.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s5", name: "Bts Jungkook 1st Solo Album Golden Sound Wave Pob Luckydraw Photocard K-pop", price: "Rp120.000", priceValue: 120000, imageUrl: "${proxy}https://i.pinimg.com/1200x/af/42/62/af42620cb5fb9d12cd4bea2f37399f35.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s6", name: "Official BTS Arirang Rooted in Music Photo Cards", price: "Rp100.000", priceValue: 100000, imageUrl: "${proxy}https://i.pinimg.com/1200x/f9/8c/3d/f98c3d446dd0bb88c95416c6d5018d54.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "bts_s7", name: "BTS Proof Compact Album Official Photocards (Choose member pc)", price: "Rp80.000", priceValue: 80000, imageUrl: "${proxy}https://i.pinimg.com/1200x/8e/57/5d/8e575ddeee6e4b266f890ce9031a2678.jpg", groupName: "BTS", condition: "SECOND"),
  Product(id: "svt_n1", name: "Seventeen Official Light Stick Ver.3 (10th Anniversary Ver.)", price: "Rp989.850", priceValue: 989850, imageUrl: "${proxy}https://i.pinimg.com/736x/fb/5c/31/fb5c31a8f017a978220fcc23396c311e.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n2", name: "Seventeen Miniteen Merch", price: "Rp150.000", priceValue: 150000, imageUrl: "${proxy}https://i.pinimg.com/736x/e2/58/06/e258065ab33923f538e2db2f878dde85.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n3", name: "Seventeen - Seventeenth Heaven Pm 2:14 Lenticular Photocard Binder Official MD", price: "Rp794.850", priceValue: 794850, imageUrl: "${proxy}https://i.pinimg.com/1200x/4a/e0/b2/4ae0b2d501f3ede8ace9ea2cd3968f82.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n4", name: "SEVENTEEN - SEVENTEEN 11th Mini Album 'SEVENTEENTH HEAVEN' (CARAT Ver.) (CD)", price: "Rp224.850", priceValue: 224850, imageUrl: "${proxy}https://i.pinimg.com/1200x/9f/64/bd/9f64bd0db49619192e79cb4316ab5281.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n5", name: "Seventeen BSS 2nd Single Album - Teleparty - STANDARD RANDOM", price: "Rp539.850", priceValue: 539850, imageUrl: "${proxy}https://i.pinimg.com/1200x/51/87/9b/51879b4f2a8b4c307c5e3488643e0653.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n6", name: "SERENADE ON STAGE]ID PHOTO KEYRING", price: "Rp150.000", priceValue: 150000, imageUrl: "${proxy}https://cdn-contents.weverseshop.io/public/shop/b31f7015ce88a5c829d86fb6b9cfdc4a.jpg?w=720&q=95", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_n7", name: "Puzzle SEVENTEEN X EARP EARP Magsafe WAVE LABEL+ PHONE CASES [CLEAR] (HOSHI)", price: "Rp900.000", priceValue: 900000, imageUrl: "${proxy}https://i.pinimg.com/1200x/34/e4/02/34e4029bcab41c1911aa29230a981a79.jpg", groupName: "SEVENTEEN", condition: "NEW"),
  Product(id: "svt_s1", name: "Seventeen Official Light Stick Ver.3 (10th Anniversary Ver.)", price: "Rp800.000", priceValue: 800000, imageUrl: "${proxy}https://i.pinimg.com/1200x/93/7f/6c/937f6c89003bcfc6d9ec0acfddd93a4d.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s2", name: "svt bongbongee merch", price: "Rp180.000", priceValue: 180000, imageUrl: "${proxy}https://i.pinimg.com/736x/53/0c/45/530c452113a60a982a6d9e4ffd3c8afc.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s3", name: "seungkwan seventeenth heaven carat vearsion", price: "Rp200.000", priceValue: 200000, imageUrl: "${proxy}https://i.pinimg.com/736x/23/1e/57/231e57ed7b3c675ff5257a94878d6fc1.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s4", name: "Seventeen BSS 2nd Single Album - Teleparty", price: "Rp250.000", priceValue: 250000, imageUrl: "${proxy}https://i.pinimg.com/1200x/8e/56/e6/8e56e68804313e37a82c1dd183e81bce.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s5", name: "Seventeen Right Here_Dear ver", price: "Rp280.000", priceValue: 280000, imageUrl: "${proxy}https://i.pinimg.com/736x/4d/26/9f/4d269f5e1147a0e6dcf8b3fc841ff8d4.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s6", name: "Seventeen 17 Right Here Dear Ver | Color: Blue/Pink | Size: Os", price: "Rp375.000", priceValue: 375000, imageUrl: "${proxy}https://i.pinimg.com/1200x/e0/ca/24/e0ca240d2b09a68fee0fef6ed0daf196.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "svt_s7", name: "Seventeen S Coups Doll | svt plushie | Seventeen merch", price: "Rp268.500", priceValue: 268500, imageUrl: "${proxy}https://i.pinimg.com/1200x/2b/aa/3b/2baa3bc2e23b0dd223c4942145df19f3.jpg", groupName: "SEVENTEEN", condition: "SECOND"),
  Product(id: "txt_n1", name: "TXT - The star chapter : sanctuary 7th mini album merch ver", price: "Rp704.850", priceValue: 704850, imageUrl: "${proxy}https://i.pinimg.com/1200x/38/34/a4/3834a4c931bc64f3f4b6dd8839f2773f.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n2", name: "Oppa Store TXT - Happy Taehyun Day Da-Go-Nyang Plush Set", price: "Rp705.000", priceValue: 705000, imageUrl: "${proxy}https://i.pinimg.com/1200x/42/b6/38/42b63853daa28d86f0ae87648b73b4c2.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n3", name: "TXT - [PPULBATU SNOW MAGIC] OFFICIAL MD Figure (Holiday Ver.) (Random)", price: "Rp300.000", priceValue: 300000, imageUrl: "${proxy}https://i.pinimg.com/1200x/b5/13/8e/b5138ed0fa5e40db17b87f7b4d729c6d.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n4", name: "TXT - Ppulbatu I the Seoul Illustration Fair V.19 Official MD BOOKMARK", price: "Rp359.850", priceValue: 359850, imageUrl: "${proxy}https://i.pinimg.com/736x/85/01/34/850134327d7077c84a10661eab0c3c5b.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n5", name: "TXT - The Star Chapter : Together Official MD Sticker Set", price: "Rp359.850", priceValue: 359850, imageUrl: "${proxy}https://i.pinimg.com/1200x/b6/95/70/b695702c36f5b0da9d35713715648418.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n6", name: "TOMORROW X TOGETHER TXT [THE STAR CHAPTER : TOGETHER] Weverse Albums Ver.", price: "Rp242.000", priceValue: 242000, imageUrl: "${proxy}https://i.pinimg.com/1200x/62/8c/d9/628cd9279b21185301a600f2cf54d5d5.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_n7", name: "TXT 7TH MINI ALBUM - THE STAR CHAPTER : SANCTUARY (CASSETTE TAPE SPEAKER VER.)", price: "Rp749.250", priceValue: 749250, imageUrl: "${proxy}https://i.pinimg.com/736x/0c/06/fe/0c06fe2ef9ee961fac2f2cfba1833192.jpg", groupName: "TXT", condition: "NEW"),
  Product(id: "txt_s1", name: "txt together starlight album", price: "Rp220.000", priceValue: 220000, imageUrl: "${proxy}https://i.pinimg.com/736x/c9/ab/3c/c9ab3c16380e48cd09f8e5fc4f543015.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "txt_s2", name: "album TXT - MINISODE 3: TOMORROW - (Wvs B ver.)", price: "Rp230.000", priceValue: 230000, imageUrl: "${proxy}https://i.pinimg.com/736x/e1/1c/8d/e11c8d9d629a9894c8a2c4616e94c65a.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "txt_s3", name: "TXT Sanctuary Photocard Pulls", price: "Rp85.000", priceValue: 85000, imageUrl: "${proxy}https://i.pinimg.com/736x/dd/f7/e0/ddf7e06d383ac35194807c89537514a9.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "txt_s4", name: "soobin blue hour", price: "Rp120.000", priceValue: 120000, imageUrl: "${proxy}https://i.pinimg.com/1200x/b6/61/b7/b661b7f66acf8cc40d9b8db3b3a09703.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "txt_s5", name: "txt huening kai 240823", price: "Rp60.000", priceValue: 60000, imageUrl: "${proxy}https://i.pinimg.com/736x/2a/54/4d/2a544d5b20c79aa8c57578f56e8d72d7.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "txt_s6", name: "Txt Trading Card Yeonjun Tomorrow X Together Special Offer Used Single", price: "Rp1.305.000", priceValue: 1305000, imageUrl: "${proxy}https://i.pinimg.com/1200x/a7/35/19/a73519ca84dd6b1a9df9c0409077bd92.jpg", groupName: "TXT", condition: "SECOND"),
  Product(id: "enh_n1", name: "ENHYPEN 6th Mini Album DESIRE : UNLEASH", price: "Rp350.000", priceValue: 350000, imageUrl: "${proxy}https://i.pinimg.com/736x/8c/04/ef/8c04ef35ca31c3b343158498329d1862.jpg", groupName: "ENHYPEN", condition: "NEW"),
  Product(id: "enh_n2", name: "ENHYPEN 2nd Album - Romance: Untold (Set)", price: "Rp1.409.850", priceValue: 1409850, imageUrl: "${proxy}https://i.pinimg.com/736x/45/1e/4e/451e4e2dea9bbf0a1dbfec908e5a1b42.jpg", groupName: "ENHYPEN", condition: "NEW"),
  Product(id: "enh_n3", name: "ENHYPEN - 7th Mini Album 'THE SIN : VANISH' (Target Exclusive, CD)", price: "Rp449.850", priceValue: 449850, imageUrl: "${proxy}https://i.pinimg.com/1200x/02/fc/98/02fc989d27a7ca9d0163f0feacf55c93.jpg", groupName: "ENHYPEN", condition: "NEW"),
  Product(id: "enh_n4", name: "ENHYPEN - [MANIFESTO : DAY 1] (D Ver.)", price: "Rp300.000", priceValue: 300000, imageUrl: "${proxy}https://i.pinimg.com/1200x/e0/e6/59/e0e659f25a2338887d41cddc9295804a.jpg", groupName: "ENHYPEN", condition: "NEW"),
  Product(id: "enh_n5", name: "ENHYPEN DESIRE: UNLEASH", price: "Rp320.000", priceValue: 320000, imageUrl: "${proxy}https://i.pinimg.com/736x/77/ca/08/77ca08c9ebd7068f90c002c364b0f239.jpg", groupName: "ENHYPEN", condition: "NEW"),
  Product(id: "enh_s1", name: "Enhypen Photo Card Set official PS1", price: "Rp309.600", priceValue: 309600, imageUrl: "${proxy}https://i.pinimg.com/1200x/a4/c2/bb/a4c2bb41173e2e8fe9f0daef144dc947.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "enh_s2", name: "Enhypen Dimension: Answer Type One Ver. 2022 | Color: Gray/Red | Size: Na", price: "Rp225.000", priceValue: 225000, imageUrl: "${proxy}https://i.pinimg.com/1200x/0f/62/0f/0f620fd41f67d56406641b45c49f866b.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "enh_s3", name: "Enhypen Manifesto day 1 Album unboxing J version engene version", price: "Rp180.000", priceValue: 180000, imageUrl: "${proxy}https://i.pinimg.com/736x/2f/53/0c/2f530cd5db946faaa25c9bb6c38a242d.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "enh_s4", name: "enhypen romance:untold album", price: "Rp200.000", priceValue: 200000, imageUrl: "${proxy}https://i.pinimg.com/736x/95/8d/e5/958de59d34182f890e19b6121e942853.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "enh_s5", name: "enhypen dicon headphone pc", price: "Rp95.000", priceValue: 95000, imageUrl: "${proxy}https://i.pinimg.com/736x/81/3f/9e/813f9e1dba51f9c9aaa59dca2374700d.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "enh_s6", name: "Jake Dark Blood PC", price: "Rp110.000", priceValue: 110000, imageUrl: "${proxy}https://i.pinimg.com/1200x/41/10/62/411062233167c7ebe0168e8f2dfca636.jpg", groupName: "ENHYPEN", condition: "SECOND"),
  Product(id: "cor_n1", name: "Cortis - Greengreen (studio ver.) (Walmart Exclusive) - Music & Performance - CD [Exclusive]", price: "Rp344.550", priceValue: 344550, imageUrl: "${proxy}https://i.pinimg.com/736x/34/2a/2f/342a2ffcc11d5a6bbc45047a35f80a94.jpg", groupName: "CORTIS", condition: "NEW"),
  Product(id: "cor_n2", name: "CORTIS 1st EP Album [Color Outside The Lines]", price: "Rp350.000", priceValue: 350000, imageUrl: "${proxy}https://i.pinimg.com/1200x/ff/09/60/ff096039d1eef4f0a4f5cabe58180929.jpg", groupName: "CORTIS", condition: "NEW"),
  Product(id: "cor_n3", name: "Oppa Store CORTIS The 1st EP [COLOR OUTSIDE THE LINES] Album, RANDOM (Standard version)", price: "Rp345.000", priceValue: 345000, imageUrl: "${proxy}https://i.pinimg.com/1200x/3a/d4/15/3ad41500cd25464d39a274041eb33214.jpg", groupName: "CORTIS", condition: "NEW"),
  Product(id: "cor_n4", name: "cortis magazine fanmade poster", price: "Rp100.000", priceValue: 100000, imageUrl: "${proxy}https://i.pinimg.com/736x/3c/d8/4c/3cd84ca1c33ba00320a5a43c52ae69e5.jpg", groupName: "CORTIS", condition: "NEW"),
  Product(id: "cor_s1", name: "PC’C KEONHO Y MARTIN", price: "Rp80.000", priceValue: 80000, imageUrl: "${proxy}https://i.pinimg.com/736x/00/d3/26/00d32653a028bbe5f02935045da9893c.jpg", groupName: "CORTIS", condition: "SECOND"),
  Product(id: "cor_s2", name: "color outside the lines", price: "Rp250.000", priceValue: 250000, imageUrl: "${proxy}https://i.pinimg.com/736x/72/47/83/7247834316accb9b4efb81426bba0fd8.jpg", groupName: "CORTIS", condition: "SECOND"),
  Product(id: "cor_s3", name: "cortis’ color outside the lines scene 2 pulls", price: "Rp75.000", priceValue: 75000, imageUrl: "${proxy}https://i.pinimg.com/736x/03/91/85/039185a9b678aa2b5c37248eda93a0ce.jpg", groupName: "CORTIS", condition: "SECOND"),
  Product(id: "cor_s4", name: "Cortis Martin photocard collection", price: "Rp90.000", priceValue: 90000, imageUrl: "${proxy}https://i.pinimg.com/736x/ca/8a/77/ca8a7742d8a51aba758f1cd6017dd1d4.jpg", groupName: "CORTIS", condition: "SECOND"),
  Product(id: "cor_s5", name: "seonghyeon pc", price: "Rp100.000", priceValue: 100000, imageUrl: "${proxy}https://i.pinimg.com/736x/75/ef/2b/75ef2b2807ce5a2cf999e7a909af2f29.jpg", groupName: "CORTIS", condition: "SECOND"),
  Product(id: "bp_n1", name: "BLACKPINK: THE VIRTUAL Exclusive Merchandise", price: "Rp300.000", priceValue: 300000, imageUrl: "${proxy}https://i.pinimg.com/1200x/32/97/a0/3297a0df15c6cfc2951d594ac9de8d58.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n2", name: "Rosi new merchandise!", price: "Rp250.000", priceValue: 250000, imageUrl: "${proxy}https://i.pinimg.com/736x/b5/79/32/b5793277ff2a477a231a9f265bc4a98a.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n3", name: "MINISO X JENNIE", price: "Rp180.000", priceValue: 180000, imageUrl: "${proxy}https://i.pinimg.com/736x/1c/70/be/1c70bee0a9a7f279cfa8b70aecb0f8af.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n4", name: "JENNIE || BEATS SPECIAL ADDITION SOLO 4", price: "Rp400.000", priceValue: 400000, imageUrl: "${proxy}https://i.pinimg.com/736x/aa/75/c9/aa75c9d0f6ce80968034e126a5cd99d0.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n5", name: "Blackpink - Blackpink 3rd Mini Album [Deadline] Pink Version (CD)", price: "Rp404.550", priceValue: 404550, imageUrl: "${proxy}https://i.pinimg.com/1200x/16/ed/c0/16edc03c8244e32996d0c74e51cfea13.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n6", name: "Blackpink - Blackpink 3rd Mini Album [Deadline] Gray Version (CD)", price: "Rp479.550", priceValue: 479550, imageUrl: "${proxy}https://i.pinimg.com/1200x/b3/0a/25/b30a25a41d3057eeda5febcc4bd31e70.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_n7", name: "(LUCKY DRAW) BLACKPINK - [DEADLINE] 3rd Mini Album SILVER JISOO Version", price: "Rp184.200", priceValue: 184200, imageUrl: "${proxy}https://i.pinimg.com/736x/e3/c5/0f/e3c50f3c74e9454e967dd63ee2c48ec1.jpg", groupName: "BLACKPINK", condition: "NEW"),
  Product(id: "bp_s1", name: "Blackpink Doll", price: "Rp150.000", priceValue: 150000, imageUrl: "${proxy}https://i.pinimg.com/736x/23/97/f8/2397f8ff461b9cb5d5ff4b6e8bcfe7bb.jpg", groupName: "BLACKPINK", condition: "SECOND"),
  Product(id: "bp_s2", name: "Jennie Gomdeuki plushie", price: "Rp200.000", priceValue: 200000, imageUrl: "${proxy}https://i.pinimg.com/736x/21/6c/20/216c200561dffd655598f1879962673f.jpg", groupName: "BLACKPINK", condition: "SECOND"),
  Product(id: "bp_s3", name: "blackpink signed born pink", price: "Rp400.000", priceValue: 400000, imageUrl: "${proxy}https://i.pinimg.com/1200x/d7/1a/f4/d71af402f8cc570e481ef43487b9d12c.jpg", groupName: "BLACKPINK", condition: "SECOND"),
  Product(id: "bp_s4", name: "BLACKPINK - \"BORN PINK\" WORLD TOUR MD PHOTOCARD", price: "Rp90.000", priceValue: 90000, imageUrl: "${proxy}https://i.pinimg.com/1200x/60/e6/88/60e688a65fb796f99243182afc65d8af.jpg", groupName: "BLACKPINK", condition: "SECOND"),
  Product(id: "bp_s5", name: "blackpink born pink album box ver pink ver", price: "Rp220.000", priceValue: 220000, imageUrl: "${proxy}https://i.pinimg.com/736x/2c/7c/15/2c7c1553811162aceef816f38abcbb47.jpg", groupName: "BLACKPINK", condition: "SECOND"),
  Product(id: "bp_s6", name: "BLACKPINK 3rd MINI ALBUM [DEADLINE] MOOD LIGHT Ver.", price: "Rp280.000", priceValue: 280000, imageUrl: "${proxy}https://i.pinimg.com/736x/29/5c/84/295c84637e20450cc437b2e814113300.jpg", groupName: "BLACKPINK", condition: "SECOND"),
];

final List<String> groupList = ['BTS', 'SEVENTEEN', 'TXT', 'ENHYPEN', 'CORTIS', 'BLACKPINK'];