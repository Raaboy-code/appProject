// lib/aba_pay_page.dart
import 'package:electric_app/pages/delivery.dart';
import 'package:flutter/material.dart';

class AbaPayPage extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>> selectedItems; // Keep if you need to pass it further

  const AbaPayPage({
    Key? key,
    required this.total,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the dark blue color used in the image
    const Color primaryDarkBlue = Color(0xFF0D254C);
    const Color redButtonColor = Color(0xFFEA0000);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDarkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const Text(
              'ABA',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            right: -60,
            bottom: -60,
            child: Opacity(
              opacity: 0.08,
              child: Text(
                '\$',
                style: TextStyle(
                  fontSize: 280,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  color: primaryDarkBlue, // Dark blue background for the main content
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          // If you have the actual logo:
                          image: DecorationImage(
                            image: AssetImage('assets/images/Logoelictric.jpg'), // Path to your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Van Tara',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline, // Align baselines
                        textBaseline: TextBaseline.alphabetic, // Required for crossAxisAlignment.baseline
                        children: [
                          Text(
                            total.toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: redButtonColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'USD', // Pay in Khmer (from image)
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Account :',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '004 041 648',
                            style: TextStyle(
                                color: Color(0xFF00abbc),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '| USD',
                            style: TextStyle(color: Color(0xFF00abbc), fontSize: 16),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Color(0xFF00abbc), ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      InkWell( // Use InkWell for a clickable "Edit" area
                        onTap: () {
                          // Handle edit action
                          print('Edit button pressed');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1.5), // Slightly thicker border
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Wrap content horizontally
                            children: const [
                              Icon(Icons.edit, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Note', // Edit in Khmer
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Add more spacing if needed
                    ],
                  ),
                ),
              ),
              // Bottom "Pay" button
              Container(
                width: double.infinity,
                // height: 60, // Fixed height for button
                padding: const EdgeInsets.symmetric(vertical: 16.0), // Padding to make it taller
                color: redButtonColor, // Red background for the button container
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveryPage(
                          selectedItems: selectedItems, // Pass the selectedItems
                          total: total, // Pass the total
                          paymentMethod: 'ABA Pay', // Or whatever specific string you want for ABA
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}