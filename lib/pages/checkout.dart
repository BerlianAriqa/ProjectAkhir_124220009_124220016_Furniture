import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/pages/ordersukses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartProducts; // Accepting cart products

  const CheckoutPage({Key? key, required this.cartProducts}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPaymentMethod;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(); // Controller for name
  String? userName; // Variable to hold the user's name

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load the user's name when the widget initializes
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Assuming the user's name is stored with the key 'userName'
      userName = prefs.getString('userName');
      _nameController.text = userName ?? ''; // Set the name controller text
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = widget.cartProducts.fold(0, (sum, product) {
      return sum + (product['price'] * product['quantity']);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              hint: const Text('Choose payment method'),
              icon: const Icon(CupertinoIcons.chevron_down), // Custom dropdown icon
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              items: <String>['Credit Card', 'ShopeePay', 'Bank Transfer', 'Gopay', 'Dana']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Display selected products
            const Text(
              'Selected Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.cartProducts.map((product) {
              return ListTile(
                title: Text(product['name']),
                subtitle: Text('Price: \$${product['price']}  Quantity: ${product['quantity']}'),
              );
            }).toList(),
            const SizedBox(height: 20),
            // Display total price
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Confirm Order Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_addressController.text.isNotEmpty && selectedPaymentMethod != null) {
                    // Navigate to order success page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
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
                  'CONFIRM ORDER',
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
      ),
    );
  }
}