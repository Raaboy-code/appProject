import 'package:flutter/material.dart';
import 'delivery.dart';
import 'abapay.dart';
import 'khqr.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const PaymentPage({super.key, required this.selectedItems});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final List<Map<String, String>> validCards = [
    {
      "number": "1122 3344 5566 7788",
      "expiry": "07/27",
      "cvv": "123"
    },
    {
      "number": "1222 3333 4444 5555",
      "expiry": "08/28",
      "cvv": "456"
    },
    {
      "number": "4111 1111 1111 1111",
      "expiry": "12/25",
      "cvv": "789"
    }
  ];

  bool _isValidCard() {
    return validCards.any((card) =>
    _cardNumberController.text.trim() == card['number'] &&
        _expiryDateController.text.trim() == card['expiry'] &&
        _cvvController.text.trim() == card['cvv']);
  }


  @override
  Widget build(BuildContext context) {
    double total = widget.selectedItems.fold(
      0.0,
          (sum, item) => sum + (item['price'] * item['quantity']),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Container(
        color: const Color(0xFFe1e1e1),
        child: Column(
          children: [
            _buildAddressSection(),

            // Item List
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  final item = widget.selectedItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.asset(item['image'], width: 50, height: 50),
                      title: Text(item['name']),
                      subtitle: Text("Qty: ${item['quantity']}"),
                      trailing: Text("\$${item['price'].toStringAsFixed(2)}"),
                    ),
                  );
                },
              ),
            ),

            // Payment Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select payment method",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Choose the method you want to use for this payment"),
                  const SizedBox(height: 10),
                  _buildPaymentOption("ABA Pay", "Select to pay with ABA Bank", Icons.account_balance),
                  _buildPaymentOption("KHQR", "Select to scan to pay with bank app", Icons.qr_code),
                  _buildPaymentOption("Master card", "Select to pay with credit/debit card", Icons.credit_card),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Total + Place Order (disabled if Mastercard)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  const Text("Total:", style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  Text("\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _selectedPaymentMethod != null &&
                        _selectedPaymentMethod != "Master card"
                        ? () {
                      _handlePlaceOrder(context, total);
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF377E6D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, size: 40),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mr. Samnang", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Prasat Bakong, Siem Reap"),
                Text("Phone Number: 015-454-254"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, IconData icon) {
    final isSelected = _selectedPaymentMethod == title;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });

        if (title == "Master card") {
          _showMasterCardModal(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade800 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
          title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
          subtitle: Text(subtitle, style: TextStyle(color: isSelected ? Colors.white70 : Colors.black54)),
        ),
      ),
    );
  }

  void _handlePlaceOrder(BuildContext context, double total) {
    switch (_selectedPaymentMethod) {
      case "ABA Pay":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AbaPayPage(
              selectedItems: widget.selectedItems,
              total: total,
            ),
          ),
        );
        break;
      case "KHQR":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KhqrPage(
              selectedItems: widget.selectedItems,
              total: total,
            ),
          ),
        );
        break;
    }
  }

  void _showMasterCardModal(BuildContext context) {
    double total = widget.selectedItems.fold(
      0.0,
          (sum, item) => sum + (item['price'] * item['quantity']),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enter Card Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _expiryDateController,
                    decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                    keyboardType: TextInputType.datetime,
                  ),
                  TextField(
                    controller: _cvvController,
                    decoration: const InputDecoration(labelText: 'CVV'),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isValidCard()) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryPage(
                                selectedItems: widget.selectedItems,
                                total: total,
                                paymentMethod: _selectedPaymentMethod!,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid card details. Please try again."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF377E6D),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Confirm Payment", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
