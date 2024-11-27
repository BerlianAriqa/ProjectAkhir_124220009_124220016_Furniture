import 'package:flutter/material.dart';
import 'package:furnitur/pages/homepage.dart';
import 'pages/register.dart'; // Import RegisterScreen
import 'pages/login.dart'; // Import LoginScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture App',
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/getstart.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center( // Center the content
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Side padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Align to the center vertically
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
              children: [
                Text(
                  'MAKE YOUR OWN HOME',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 56, 48, 48),// Set color to match your design
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Transformasi ruang Anda dengan furnitur berkualitas. Temukan gaya yang sesuai dengan selera Anda.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: const Color.fromARGB(255, 56, 48, 48), // Set color to match your design
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32.0), // Space between text and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}