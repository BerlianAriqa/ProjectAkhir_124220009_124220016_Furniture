import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/pages/API.dart';
import 'package:furnitur/pages/cartpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  final Payload product;
  final Function(Payload)? onRemoveFavorite; // Callback untuk menghapus favorit

  const ProductDetailScreen({
    Key? key,
    required this.product,
    this.onRemoveFavorite,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  int quantity = 1; // Default quantity

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favoriteProducts') ?? [];
    setState(() {
      isFavorite = widget.product.id != null && favorites.contains(widget.product.id);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favoriteProducts') ?? [];
    String? productId = widget.product.id;

    if (productId != null) {
      if (isFavorite) {
        favorites.remove(productId);
        if (widget.onRemoveFavorite != null) {
          widget.onRemoveFavorite!(widget.product);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.product.name} dihapus dari favorit!'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        favorites.add(productId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.product.name} ditambahkan ke favorit!'),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      await prefs.setStringList('favoriteProducts', favorites);
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  Future<void> _addToCart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final cartProducts = prefs.getStringList('cartProducts') ?? [];

    final newProduct = {
      'id': widget.product.id,
      'name': widget.product.name,
      'image': widget.product.imgLink,
      'price': widget.product.price,
      'quantity': quantity,
    };

    cartProducts.add(jsonEncode(newProduct));
    await prefs.setStringList('cartProducts', cartProducts);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} ditambahkan ke keranjang!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image with rounded corners
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                widget.product.imgLink ?? '',
                width: double.infinity, // Full width
                height: 700, // Desired height
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name ?? '',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleFavorite,
                        child: Icon(
                          isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: isFavorite ? CupertinoColors.systemRed : CupertinoColors.inactiveGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.product.currency} ${widget.product.price}',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.product.description ?? 'Tidak ada deskripsi tersedia.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  // Row for Quantity Selector and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Selector
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.minus),
                            onPressed: _decrementQuantity,
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.plus),
                            onPressed: _incrementQuantity,
                          ),
                        ],
                      ),
                      // Add to Cart Button
                      ElevatedButton(
                        onPressed: () => _addToCart(context),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50), // Fixed width for the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'ADD TO CART',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}