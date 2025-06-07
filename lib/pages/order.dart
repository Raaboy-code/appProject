// lib/order.dart
import 'package:flutter/material.dart';
import 'delivery.dart'; // Import your original DeliveryPage

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  // --- Mock Data for Orders ---
  // This data structure now includes all necessary info to pass to DeliveryPage
  // even if DeliveryPage itself doesn't use all of it dynamically.
  final List<Map<String, dynamic>> mockOrders = const [
    {
      'orderId': 'ODR-00001',
      'orderDate': 'May 28, 2025',
      'status': 'Delivered', // For display in OrderPage list
      'total': 125.00,
      'paymentMethod': 'KHQR',
      'items': [ // Corresponds to selectedItems in DeliveryPage
        {
          'name': 'Apple Watch Series 7',
          'image': 'assets/images/apple_watch.png',
          'quantity': 1,
          'price': 100.00,
          'color': 'Midnight Blue'
        },
        {
          'name': 'AirPods Pro',
          'image': 'assets/images/airpods.png',
          'quantity': 1,
          'price': 25.00,
          'color': 'White'
        },
      ],
      // 'tracking' data is present here but won't be used by the unchanged DeliveryPage
    },
    {
      'orderId': 'ODR-00002',
      'orderDate': 'May 30, 2025',
      'status': 'Pending',
      'total': 75.50,
      'paymentMethod': 'Cash on Delivery',
      'items': [
        {
          'name': 'USB-C Cable',
          'image': 'assets/images/usb_c_cable.png',
          'quantity': 2,
          'price': 10.00,
          'color': 'Black'
        },
        {
          'name': 'Power Bank 10000mAh',
          'image': 'assets/images/power_bank.png',
          'quantity': 1,
          'price': 55.50,
          'color': 'Grey'
        },
      ],
    },
    {
      'orderId': 'ODR-00003',
      'orderDate': 'June 01, 2025',
      'status': 'Shipped',
      'total': 300.00,
      'paymentMethod': 'Credit Card',
      'items': [
        {
          'name': 'Wireless Headphones',
          'image': 'assets/images/headphones.png',
          'quantity': 1,
          'price': 200.00,
          'color': 'Black'
        },
        {
          'name': 'Gaming Mouse',
          'image': 'assets/images/gaming_mouse.png',
          'quantity': 1,
          'price': 100.00,
          'color': 'Red'
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryBackgroundColor = Color(0xFFF0F2F5);
    const Color cardBackgroundColor = Colors.white;
    const Color sectionTitleColor = Color(0xFF212121);
    const Color greyTextColor = Colors.grey;

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen (e.g., Home)
          },
        ),
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockOrders.length,
        itemBuilder: (context, index) {
          final order = mockOrders[index];
          // Extract the specific parameters that DeliveryPage expects
          final List<Map<String, dynamic>> itemsForDeliveryPage =
          List<Map<String, dynamic>>.from(order['items']);
          final double totalForDeliveryPage = order['total'];
          final String paymentMethodForDeliveryPage = order['paymentMethod'];

          return GestureDetector(
            onTap: () {
              // Navigate to the DeliveryPage, passing the required parameters
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryPage(
                    selectedItems: itemsForDeliveryPage,
                    total: totalForDeliveryPage,
                    paymentMethod: paymentMethodForDeliveryPage,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              color: cardBackgroundColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID: ${order['orderId']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: sectionTitleColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order['status']),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order['status'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Date: ${order['orderDate']}",
                      style: TextStyle(fontSize: 14, color: greyTextColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Items: ${order['items'].length}",
                      style: TextStyle(fontSize: 14, color: greyTextColor),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Total: \$${order['total'].toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: sectionTitleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green.shade600;
      case 'Shipped':
        return Colors.orange.shade600;
      case 'Pending':
        return Colors.blue.shade600;
      default:
        return Colors.grey;
    }
  }
}