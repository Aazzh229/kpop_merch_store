import 'package:flutter/material.dart';
import '../models/product.dart'; 

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<String> bannerImages = [
    '${proxy}https://i.pinimg.com/736x/e5/14/3d/e5143de2d053023155b9bd894859cd49.jpg',
    '${proxy}https://i.pinimg.com/736x/7c/3e/93/7c3e93939684296645035a493cb4666b.jpg',
    '${proxy}https://i.pinimg.com/736x/95/d3/83/95d383d815a0307d03288af2a8cb310a.jpg',
    '${proxy}https://i.pinimg.com/736x/8f/22/79/8f22797d1ad578c7364abfe09e012805.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380, width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                bannerImages[index], fit: BoxFit.cover, width: double.infinity,
                loadingBuilder: (c, child, p) => p == null ? child : const Center(child: CircularProgressIndicator(color: Colors.pink)),
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Icon(Icons.image_not_supported)),
              );
            },
          ),
          Positioned(
            left: 10, top: 0, bottom: 0,
            child: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white, size: 36), onPressed: () {
              if (_currentPage > 0) _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            }),
          ),
          Positioned(
            right: 10, top: 0, bottom: 0,
            child: IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white, size: 36), onPressed: () {
              if (_currentPage < bannerImages.length - 1) _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            }),
          ),
          Positioned(
            bottom: 12, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(bannerImages.length, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4), width: 8, height: 8,
                decoration: BoxDecoration(color: _currentPage == index ? Colors.white : Colors.white54, shape: BoxShape.circle),
              )),
            ),
          )
        ],
      ),
    );
  }
}