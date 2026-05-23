import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final String rating;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    this.isFavorite = false
  });
}

class ProductProvider with ChangeNotifier {
  final List<Product> _product = [
    Product(id: '1', title: 'Berries', description: 'Berries is a sweet fruit with red color.', image: 'assets/images/berries.png', rating: '4.5 (200)'),
    Product(id: '2', title: 'Tulsi', description: 'Leaf of berries is very green and fresh.', image: 'assets/images/tulsi.png', rating: '4.9 (324)'),
    Product(id: '3', title: 'Milk', description: 'Milk is a white liquid produced by mammals.', image: 'assets/images/milk.png', rating: '4.5 (672)'),
    Product(id: '4', title: 'Tomato', description: 'Is tomato a fruit or a vegetable?', image: 'assets/images/tomato.png', rating: '4.9 (324)')
  ];

  List<Product> get products => _product;

  void toggleFavorite(String id){
    final index = _product.indexWhere((prod) => prod.id == id);
    if (index != -1) {
      _product[index].isFavorite = !_product[index].isFavorite;
      notifyListeners();
    }
  }
}