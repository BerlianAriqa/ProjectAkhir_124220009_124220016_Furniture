import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/pages/checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartProducts = [];

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
  }

  Future<void> _loadCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList('cartProducts') ?? [];
    setState(() {
      cartProducts = cartItems
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList('cartProducts') ?? [];
    cartItems.removeAt(index);
    await prefs.setStringList('cartProducts', cartItems);
    setState(() {
      cartProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Daftar produk dalam keranjang
          cartProducts.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            product['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product['name']),
                          subtitle: Text(
                            'Price: \$${product['price']} \nQuantity: ${product['quantity']}',
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(CupertinoIcons.delete),
                            onPressed: () => _removeFromCart(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          // Tombol Checkout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (cartProducts.isEmpty) {
                  // Show a snackbar if the cart is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your cart is empty. Please add products to checkout.')),
                  );
                } else {
                  // Navigasi ke halaman checkout dengan produk yang dipilih
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(cartProducts: cartProducts), // Pass the cart products
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Full-width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'CHECKOUT',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}