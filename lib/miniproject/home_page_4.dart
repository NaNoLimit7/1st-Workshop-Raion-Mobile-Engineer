import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workshop_1/miniproject/widget/carousel_view_widget.dart';
import 'package:workshop_1/miniproject/widget/category_card.dart';
import 'package:workshop_1/miniproject/widget/page_view_widget.dart';
import 'package:workshop_1/miniproject/widget/product_card.dart';
import 'package:workshop_1/miniproject/providers/product_provider.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  late PageController _pageController;
  late CarouselController _carouselController;
  final double _carouselItemExtend = 300;
  int pageCount = 5;
  int _pageViewPage = 0;
  int _carouselPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _carouselController = CarouselController();
    _carouselController.addListener(() {
      setState(() {
        _carouselPage = (_carouselController.offset / _carouselItemExtend)
            .round();
      });
    });
    _pageController.addListener(() {
      setState(() {
        _pageViewPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Explore",
          style: TextStyle(
            color: Color(0xFF007E2F),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: Image.asset('assets/icons/search.png', width: 18),
                    ),
                    hintText: 'Search..',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF939393),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF505050),
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              CarouselViewWidget(
                carouselController: _carouselController,
                carouselItemExtend: _carouselItemExtend,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: List.generate(
                  pageCount,
                  (index) => Container(
                    width: 6,
                    height: 6,
                    decoration: ShapeDecoration(
                      color: _carouselPage == index
                          ? const Color(0xFF007E2F)
                          : const Color(0xFFD9D9D9),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ),

              PageViewWidget(pageController: _pageController),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: List.generate(
                  pageCount,
                  (index) => Container(
                    width: 6,
                    height: 6,
                    decoration: ShapeDecoration(
                      color: _pageViewPage == index
                          ? const Color(0xFF007E2F)
                          : const Color(0xFFD9D9D9),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ),

              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),

              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 5,
                  children: [
                    CategoryCard(
                      title: 'Fruits',
                      image: 'assets/images/fruits.png',
                    ),
                    CategoryCard(
                      title: 'Grains',
                      image: 'assets/images/grains.png',
                    ),
                    CategoryCard(
                      title: 'Herbs',
                      image: 'assets/images/herbs.png',
                    ),
                  ],
                ),
              ),

              const Text(
                'Browse Products',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),

              // [CUKUP GUNAKAN CONSUMER SAJA, GRIDVIEW LAMA DIHAPUS]
              Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 280,
                        ),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return ProductCard(
                        id: product.id,
                        title: product.title,
                        description: product.description,
                        image: product.image,
                        rating: product.rating,
                        isFavorite: product.isFavorite,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
