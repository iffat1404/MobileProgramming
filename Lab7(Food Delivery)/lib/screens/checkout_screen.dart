import 'package:flutter/material.dart';
import 'package:lab_7_food_delivery/theme/app_theme.dart';
import 'package:lab_7_food_delivery/widgets/address_card.dart';
import 'package:lab_7_food_delivery/widgets/payment_method_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0;
  
  final List<Map<String, dynamic>> _addresses = [
    {
      'name': 'Home',
      'address': '123 Main St, Apt 4B, New York, NY 10001',
      'icon': Icons.home,
    },
    {
      'name': 'Work',
      'address': '456 Business Ave, Suite 200, New York, NY 10018',
      'icon': Icons.work,
    },
  ];
  
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Credit Card',
      'details': '**** **** **** 4582',
      'icon': Icons.credit_card,
    },
    {
      'name': 'PayPal',
      'details': 'johndoe@example.com',
      'icon': Icons.account_balance_wallet,
    },
    {
      'name': 'Cash on Delivery',
      'details': 'Pay when you receive',
      'icon': Icons.money,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Address",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                return AddressCard(
                  name: _addresses[index]['name'],
                  address: _addresses[index]['address'],
                  icon: _addresses[index]['icon'],
                  isSelected: _selectedAddressIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedAddressIndex = index;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // Add new address
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Address"),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Payment Method",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                return PaymentMethodCard(
                  name: _paymentMethods[index]['name'],
                  details: _paymentMethods[index]['details'],
                  icon: _paymentMethods[index]['icon'],
                  isSelected: _selectedPaymentIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedPaymentIndex = index;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // Add new payment method
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Payment Method"),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Order Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text("\$24.97"),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Fee"),
                        Text("\$2.99"),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax"),
                        Text("\$2.25"),
                      ],
                    ),
                    Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "\$30.21",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            _showOrderConfirmation(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text("Place Order"),
        ),
      ),
    );
  }
  
  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order Placed!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: AppTheme.accentColor,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                "Your order has been placed successfully!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Order #FE-2023-04-15",
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "You can track your order in the 'My Orders' section.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Back to Home"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to order tracking
              },
              child: const Text("Track Order"),
            ),
          ],
        );
      },
    );
  }
}
