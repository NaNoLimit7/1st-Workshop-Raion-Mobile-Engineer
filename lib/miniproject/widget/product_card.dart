import 'dart:ui'; // Dibutuhkan untuk ImageFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:workshop_1/miniproject/detail_page.dart';
import 'package:workshop_1/miniproject/providers/product_provider.dart'; // Sesuaikan dengan path file provider Anda

// BERUBAH JADI StatelessWidget
class ProductCard extends StatelessWidget {
  final String id; // Tambahkan ID produk untuk dikirim ke DetailPage & Provider
  final String title;
  final String description;
  final String image;
  final String rating;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.id, // Require id
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke DetailPage yang baru: Cukup kirimkan ID-nya saja!
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(productId: id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image), // Hapus 'widget.' karena sekarang Stateless
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    // ACTION: Langsung panggil toggleFavorite dari Provider!
                    context.read<ProductProvider>().toggleFavorite(id);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: isFavorite // Tampilkan icon berdasarkan state dari parameter
                            ? const Icon(Icons.favorite, color: Colors.red, size: 20)
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title, // Hapus 'widget.'
            style: const TextStyle(
              color: Color(0xFF505050),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            spacing: 4,
            children: [
              Icon(Icons.star, color: Colors.yellow[700], size: 16),
              RichText(
                text: TextSpan(
                  text: rating.substring(0, 3), // Hapus 'widget.'
                  style: const TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: rating.substring(3), // Hapus 'widget.'
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
          const SizedBox(height: 6),
          Text(
            description, // Hapus 'widget.'
            maxLines: 2,
            style: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              color: const Color(0xFF939393),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}