import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const KpopMerchApp());
}

class KpopMerchApp extends StatelessWidget {
  const KpopMerchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kpop Merch Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}