import 'package:flutter/material.dart';
import 'package:electric_app/main.dart'; // <--- ADD THIS LINE to import mainAppScreenKey

class DeliveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final double total;
  final String paymentMethod;

  const DeliveryPage({
    Key? key,
    required this.selectedItems,
    required this.total,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors from the example image
    const Color primaryBackgroundColor = Color(0xFFF0F2F5); // Light grey background
    const Color cardBackgroundColor = Colors.white;
    const Color deliveredBannerColor = Color(0xFFFCE4EC); // Light pink/purple for delivered banner
    const Color deliveredTextColor = Color(0xFF424242); // Dark grey for delivered text
    const Color sectionTitleColor = Color(0xFF212121); // Darker text for titles
    const Color greyTextColor = Colors.grey; // For secondary text
    const Color accentColor = Color(0xFFE53935); // For total amount (red)

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Updated: Pop all routes until the MainAppScreen is reached,
            // then set the selected index of MainAppScreen to 0 (Home).
            Navigator.popUntil(context, (route) => route.isFirst);
            // Access the MainAppScreen state via its GlobalKey and set the index
            mainAppScreenKey.currentState?.setSelectedIndex(0); // 0 is the index for Home
          },
        ),
        title: const Text(
          "Order Detail",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black), // Three dots menu
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top "Delivered" Confirmation Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: deliveredBannerColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Delivered",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: deliveredTextColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "You have confirmed that your order has been delivered and received. Thank you for shopping with us.",
                          style: TextStyle(
                            fontSize: 14,
                            color: deliveredTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Placeholder for the illustration (teddy bear)
                  // You would replace this with an actual image asset if available
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100, // Placeholder color
                      borderRadius: BorderRadius.circular(10),
                      // Example if you have an asset:
                      // image: const DecorationImage(
                      //   image: AssetImage('assets/images/teddy_bear.png'),
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                    child: const Icon(Icons.delivery_dining, size: 40, color: Colors.pink), // Placeholder icon
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Main Order Details Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and Invoice
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID : 00001",
                            style: TextStyle(fontSize: 16, color: sectionTitleColor),
                          ),
                          Text(
                            "Order date : May 28, 2025", // Example date
                            style: TextStyle(fontSize: 14, color: greyTextColor),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Handle invoice action
                        },
                        icon: const Icon(Icons.receipt_long, size: 18, color: Colors.black54),
                        label: const Text(
                          "Invoice",
                          style: TextStyle(color: Colors.black54),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.grey),
                  // Items Ordered Section
                  Text(
                    "Items Ordered",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionTitleColor),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = selectedItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Item Image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(item['image']),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: sectionTitleColor),
                                  ),
                                  Text(
                                    "Colours: ${item['color'] ?? 'N/A'}", // Assuming 'color' might be in your item map
                                    style: TextStyle(fontSize: 13, color: greyTextColor),
                                  ),
                                  Text(
                                    "Qty: ${item['quantity']}",
                                    style: TextStyle(fontSize: 13, color: greyTextColor),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sectionTitleColor),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.grey),

                  // Payment and Delivery Sections (Two Columns)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionTitleColor),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              paymentMethod == 'KHQR' ? "KHQR *****45" : paymentMethod, // Example for KHQR
                              style: TextStyle(fontSize: 15, color: greyTextColor),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionTitleColor),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Address :",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: sectionTitleColor),
                            ),
                            const Text(
                              " Svay Thom/Siem Reap ",
                              style: TextStyle(fontSize: 14, color: greyTextColor),
                            ),
                            const Text(
                              "Phone Number: 015-454-254",
                              style: TextStyle(fontSize: 14, color: greyTextColor),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Delivery Method",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: sectionTitleColor),
                            ),
                            const Text(
                              "Delivery 1-2 days",
                              style: TextStyle(fontSize: 14, color: greyTextColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.grey),

                  // Tracking Section
                  Text(
                    "Tracking",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionTitleColor),
                  ),
                  const SizedBox(height: 10),
                  // Simple tracking visualization
                  _buildTrackingStep("28-May-2025 7:00 PM", "Deliver", "Siem Reap - PP"),
                  _buildTrackingLine(),
                  _buildTrackingStep("29-May-2025 9:00 AM", "Kampong Thom", ""),
                  const Divider(height: 30, thickness: 1, color: Colors.grey),


                  // Order Summary
                  Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionTitleColor),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Subtotal", total),
                  _buildSummaryRow("Discount", 0.00), // Assuming no discount for now
                  _buildSummaryRow("Delivery", 2.50), // Example delivery fee
                  const Divider(height: 10, thickness: 1, color: Colors.grey),
                  _buildSummaryRow("Total", total + 2.50, isTotal: true), // Calculate total with delivery
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper widget for tracking steps
  Widget _buildTrackingStep(String time, String status, String location) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              // Vertical line
              if (location.isNotEmpty)
                Container(
                  width: 2,
                  height: 30, // Adjust height as needed
                  color: Colors.black,
                ),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                status,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              if (location.isNotEmpty)
                Text(
                  location,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for tracking line (simple version)
  Widget _buildTrackingLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Container(
        width: 2,
        height: 30, // Length of the line between steps
        color: Colors.black,
      ),
    );
  }


  // Helper widget for order summary rows
  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
