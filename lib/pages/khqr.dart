import 'package:flutter/material.dart';

class KhqrPage extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>> selectedItems;

  const KhqrPage({
    Key? key,
    required this.total,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryDarkBackground = Color(0xFF1A1A2E);
    const Color lightTextColor = Colors.white;
    const Color greyTextColor = Color(0xFFAAAAAA);

    return Scaffold(
      backgroundColor: primaryDarkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: lightTextColor, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'ABA QR',
                    style: TextStyle(
                      color: lightTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // To balance the IconButton
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Instruction
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Scan this QR code to pay with ABA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: greyTextColor,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // QR image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(
                'assets/images/qr.png',
                width: 250,
                height: 550,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
