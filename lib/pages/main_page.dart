import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/components/loading.dart';
import 'package:furnitur/components/my_appbar.dart';
import 'package:furnitur/db/shared_preferences.dart';
import 'package:furnitur/pages/homepage.dart';
import 'package:furnitur/pages/login.dart';
import 'package:furnitur/pages/cartpage.dart'; // Pastikan impor ini benar

class MainPage extends StatefulWidget {
  final String username; // Menyimpan username yang diterima

  const MainPage({super.key, required this.username}); // Mengambil username dari constructor

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Indeks halaman saat ini
  late bool _isLoading = false;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    DBHelper().setPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (_currentIndex) {
        case 0:
          return const HomePage();
        default:
          return const HomePage();
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: myAppBar(
            context,
            title: 'Furniture Store',
            automaticImplyLeading: false,
            action: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.square_arrow_right, // Ikon logout dari Cupertino
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, ${widget.username}!', // Menampilkan pesan sambutan
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.cart, // Ikon cart dari Cupertino
                        color: Color.fromARGB(255, 131, 130, 130),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const CartPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: body()), // Membuat body dari halaman
            ],
          ),
        ),
        LoadingScreen(loading: _isLoading),
      ],
    );
  }
}