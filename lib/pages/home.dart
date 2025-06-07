import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'appbar.dart'; // Assuming this is your CustomAppBar
import 'footer.dart'; // Assuming this is your CustomBottomNav
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class Brand {
  final String name;
  final String imageUrl;

  Brand({required this.name, required this.imageUrl});
}

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
      discountPercentage: map['discountPercentage'],
    );
  }


  Product({
    this.id = 0,
    required this.name,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
    };
  }
}

// New data model for categories
class Category {
  final String name;
  final IconData icon; // Using IconData for built-in icons

  Category({required this.name, required this.icon});
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  final List<Widget> banners = [
    Image.asset('assets/images/banner.png', fit: BoxFit.cover),
    Image.asset('assets/images/banner.png', fit: BoxFit.cover),
    Image.asset('assets/images/banner.png')
  ];

  final List<Brand> brands = [
    Brand(name: 'Sound', imageUrl: 'assets/images/sound.png'),
    Brand(name: 'JBL', imageUrl: 'assets/images/jbl.png'),
    Brand(name: 'Sony', imageUrl: 'assets/images/sony.png'),
    Brand(name: 'Google', imageUrl: 'assets/images/google.png'),
  ];

  final List<Product> promotionItems = [
    Product(
      id: 1,
      name: 'SoundPeat Space Pro-Begie',
      imageUrl: 'assets/images/headphone2.png',
      originalPrice: 79.00,
      discountedPrice: 69.00,
      discountPercentage: 20,
    ),
    Product(
      id: 2,
      name: 'SoundPeat Space Pro-Begie',
      imageUrl: 'assets/images/headphone2.png',
      originalPrice: 79.00,
      discountedPrice: 79.00,
      discountPercentage: 0,
    ),
    Product(
      id: 3,
      name: 'SoundPeat Space Pro-Beige',
      imageUrl: 'assets/images/headphone2.png',
      originalPrice: 79.00,
      discountedPrice: 69.00,
      discountPercentage: 15,
    ),
  ];
  final List<Product> productItems = [
    Product(
      id: 1,
      name: 'SoundPeat Space Pro-Begie',
      imageUrl: 'assets/images/headphone2.png',
      originalPrice: 79.00,
      discountedPrice: 69.00,
      discountPercentage: 20,
    ),
    Product(
      id: 2,
      name: 'Sony Headphones ',
      imageUrl: 'assets/images/sony-headphone.png',
      originalPrice: 59.00,
      discountedPrice: 39.00,
      discountPercentage: 20,
    ),
    Product(
      id: 1,
      name: 'Sony Grey Headphone',
      imageUrl: 'assets/images/sony-grey-headphone.png',
      originalPrice: 79.00,
      discountedPrice: 59.00,
      discountPercentage: 20,
    ),
    // more Product instances...
  ];

  // Dummy data for categories
  final List<Category> categories = [
    Category(name: 'HeadPhone', icon: Icons.headset),
    Category(name: 'Keyboard', icon: Icons.keyboard),
    Category(name: 'Speaker', icon: Icons.speaker),
    Category(name: 'Earbuds', icon: Icons.headphones), // Using headphones for earbuds
    Category(name: 'Smart Watch', icon: Icons.watch),
    Category(name: 'Fan', icon: Icons.toys), // Using a general toy icon for fan
    Category(name: 'Laptop', icon: Icons.laptop),
    Category(name: 'Mouse', icon: Icons.mouse),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(name: 'Brann Vann tara', notificationCount: 4),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Banner
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _activePage = index;
                            });
                          },
                          itemCount: banners.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: banners[index],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 8),

                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: banners.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Categories Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          TextButton(
                            onPressed: () {

                              print('See more categories tapped');
                            },
                            child: const Text("See more", style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryItem(categories[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Brand", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("See more", style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: brands.map((brand) => _brandLogo(brand.imageUrl)).toList(),
                      ),
                      const SizedBox(height: 24),

                      const Text("Promotions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: promotionItems.length,
                          itemBuilder: (context, index) {
                            return _buildPromotionItem(promotionItems[index]);
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Products Section
                      const Text("Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: productItems.length,
                          itemBuilder: (context, index) {
                            return _buildProductItem(productItems[index]);
                          }

                      ),
                      const SizedBox(height: 24), // Add some space at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const CustomBottomNav(),

    );
  }

  Widget _valueButton(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _brandLogo(String path) {
    return Container(
      height: 40,
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(path, fit: BoxFit.contain),
    );
  }

  Widget _buildPromotionItem(Product product) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.discountedPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (product.discountPercentage > 0)
                        Text(
                          '\$${product.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (product.discountPercentage > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFF377E6D),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Text(
                  '${product.discountPercentage}%',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          Positioned(
            top: 8,
            left: 8,
            child: Icon(Icons.favorite_border, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }


  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.discountedPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (product.discountPercentage > 0)
                        Text(
                          '\$${product.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (product.discountPercentage > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF377E6D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${product.discountPercentage}%',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            Positioned(
              top: 8,
              left: 8,
              child: Icon(Icons.favorite_border, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }


  // New widget for a single category item
  Widget _buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        // Handle category tap, e.g., navigate to a category page
        print('Category tapped: ${category.name}');
      },
      child: Container(
        width: 80, // Fixed width for each category item
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade50, // Light blue background
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                color: Colors.blue, // Blue icon color
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}