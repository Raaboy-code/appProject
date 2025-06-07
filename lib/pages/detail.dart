import 'package:flutter/material.dart';
import 'home.dart';
import 'card.dart'; // Import the cart page

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  int selectedColorIndex = 0;
  bool isFavorite = false; // New state variable for favorite status

  final List<Color> colors = [Colors.black, Colors.greenAccent];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(product),
    );
  }

  // --- Updated Widget for AppBar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Product Detail'),
      centerTitle: true,
      leading: const BackButton(),
      actions: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon based on state
            color: isFavorite ? Colors.red : null, // Set color to red if favorited
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage(cartItems: [])),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- New Widget for Body Content ---
  Widget _buildBody(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                product.imageUrl,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildPriceRow(product),
            const SizedBox(height: 4),
            const Text(
              'Available in Stock',
              style: TextStyle(color: Color(0xFF377E6D), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildQuantitySelector(), // Extract Quantity selector
            const SizedBox(height: 16),
            _buildDescription(), // Extract Description
            const SizedBox(height: 16),
            _buildColorPicker(), // Extract Color picker
            const SizedBox(height: 24),
            _buildActionButtons(), // Extract Action buttons
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for Body Sections (unchanged) ---

  Widget _buildPriceRow(Product product) {
    return Row(
      children: [
        Text(
          '\$${product.discountedPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${product.originalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        const Text("Quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          color: Color(0xFF377E6D),
          onPressed: () {
            setState(() {
              if (quantity > 1) quantity--;
            });
          },
        ),
        Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          color: Color(0xFF377E6D),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Describe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Text(" • Active Noise Cancelling 35dB Reduction"),
        Text(" • Hi-Res Audio Wired"),
        Text(" • App Custom EQ, Deep Bass"),
        Text(" • Battery 125 hours (ANC ~61h)"),
        Text(" • Connect 2 devices"),
        Text(" • 65ms Low Latency"),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Color", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: colors
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
              onTap: () {
                setState(() => selectedColorIndex = entry.key);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedColorIndex == entry.key
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: entry.value,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF377E6D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              // Add buy logic
            },
            child: const Text('Buy Now', style: TextStyle( color: Colors.white),),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF377E6D)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: [
                      {
                        'id': widget.product.id,
                        'name': widget.product.name,
                        'price': widget.product.discountedPrice,
                        'originalPrice': widget.product.originalPrice,
                        'quantity': quantity,
                        'selected': true,
                        'image': widget.product.imageUrl,
                        // You might want to store the selected color as well
                        'color': colors[selectedColorIndex].value, // Store color value
                      }
                    ],
                  ),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 8),
                Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF377E6D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}