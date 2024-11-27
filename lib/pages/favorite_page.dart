import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/pages/API.dart';
import 'package:furnitur/utils/theme.dart';

class FavoritePage extends StatelessWidget {
  final List<Payload> favoriteProducts; // Menggunakan Payload
  final Function(Payload) onRemoveFavorite; // Callback untuk menghapus favorit

  const FavoritePage({
    super.key,
    required this.favoriteProducts,
    required this.onRemoveFavorite, // Tambahkan parameter callback
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom yang diinginkan
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index];
            return Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  // Tangani ketukan pada kartu produk
                  // Anda bisa mengarahkan ke halaman detail produk jika diperlukan
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          product.imgLink ?? '', // Gambar produk
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CupertinoActivityIndicator(
                                radius: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name ?? 'Nama Produk', // Nama produk
                            style: FurniFonts(context).boldQuicksand(size: 16),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              onRemoveFavorite(product); // Panggil callback untuk menghapus favorit
                            },
                            child: const Icon(CupertinoIcons.delete, color: CupertinoColors.systemRed),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}