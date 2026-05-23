import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workshop_1/miniproject/providers/product_provider.dart';

class DetailPage extends StatelessWidget {
  final String productId;

  const DetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().products.firstWhere(
      (p) => p.id == productId,
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 319,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // ACTION: Panggil fungsi toggle dari provider
                          context.read<ProductProvider>().toggleFavorite(
                            product.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: product.isFavorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        fontFamily: GoogleFonts.quicksand().fontFamily,
                      ),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 16),
                        RichText(
                          text: TextSpan(
                            text: product.rating.substring(0, 3),
                            style: const TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: product.rating.substring(3),
                                style: const TextStyle(
                                  color: Color(0xFF939393),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontFamily: GoogleFonts.quicksand().fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
