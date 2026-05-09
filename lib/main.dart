import 'package:flutter/material.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(const KStoreApp());
}

class KStoreApp extends StatelessWidget {
  const KStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-STORE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LandingPage(),
    );
  }
}