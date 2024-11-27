import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/components/touchable_opacity.dart';
import 'package:furnitur/pages/API.dart';
import 'package:furnitur/pages/detailproduk.dart';
import 'package:furnitur/pages/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Payload> products = [];
  List<Payload> favoriteProducts = [];
  bool isLoading = true;
  final Dio _dio = Dio();
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await _dio.get('https://furniture-dummy-data-api.vercel.app/data');
      if (response.statusCode == 200) {
        setState(() {
          products = (response.data['payload'] as List)
              .map((item) => Payload.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }

  void toggleFavorite(Payload product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void removeFavorite(Payload product) {
    setState(() {
      favoriteProducts.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                Color cardColor = Colors.grey[300]!;

                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      cardColor = Colors.grey[400]!;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      cardColor = Colors.grey[300]!;
                    });
                  },
                  child: TouchableOpacity(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                            // Hapus onAddFavorite dari sini
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: cardColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.network(
                              product.imgLink ?? '',
                              height: 100,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.name ?? 'Nama Produk',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${product.currency} ${product.price}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          IconButton(
                            icon: Icon(
                              favoriteProducts.contains(product)
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: favoriteProducts.contains(product) ? Colors.red : null,
                            ),
                            onPressed: () => toggleFavorite(product),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );

    if (_currentIndex == 1) {
      currentPage = FavoritePage(
        favoriteProducts: favoriteProducts,
        onRemoveFavorite: removeFavorite, // Tetap gunakan ini untuk menghapus favorit
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          currentPage,
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Favorites',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(CupertinoIcons.arrow_up),
      ),
    );
  }
}