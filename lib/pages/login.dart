import 'package:flutter/material.dart';
import 'package:furnitur/components/flushbar.dart';
import 'package:furnitur/components/loading.dart';
import 'package:furnitur/pages/main_page.dart';
import 'package:furnitur/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidation = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false; // To toggle password visibility

  @override
  void initState() {
    super.initState();
    _checkIfUserIsRegistered(); // Check if the user is registered
  }

  Future<void> _checkIfUserIsRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');

    if (savedUsername == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    }
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus(); // Dismiss keyboard
    setState(() {
      _isValidation = true;
    });
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUsername = prefs.getString('username');
      String? savedPassword = prefs.getString('password');

      if (_usernameController.text == savedUsername && _passwordController.text == savedPassword) {
        await Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _isLoading = false;
          });
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(username: _usernameController.text),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        alert(context, text: 'Username or Password is incorrect', icon: Icons.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _loginFormKey,
                    autovalidateMode: _isValidation
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),

                        Text(
                          'WELCOME BACK',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Username Field
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Password Field with Eye Icon
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible, // Toggle password visibility
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Navigate to Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Register here.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        LoadingScreen(loading: _isLoading), // Loading indicator while waiting for login
      ],
    );
  }
}
