// main.dart
import 'package:flutter/material.dart';
import 'package:electric_app/pages/home.dart';
import 'package:electric_app/pages/card.dart';
import 'package:electric_app/pages/order.dart';
import 'package:electric_app/pages/footer.dart';
import 'package:electric_app/pages/category.dart';
import 'package:electric_app/pages/profile.dart';

// --- Define a GlobalKey for MainAppScreenState to access its methods ---
// This needs to be a global variable, outside of any class.
final GlobalKey<_MainAppScreenState> mainAppScreenKey = GlobalKey<_MainAppScreenState>();
// --- End GlobalKey Definition ---


// --- Placeholder Pages (if they don't exist yet) ---

// --- End Placeholder Pages ---


// This is the main screen that will manage the Bottom Navigation and PageView
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0; // Keeps track of the currently selected bottom nav item
  late PageController _pageController; // Controller for the PageView

  // List of all the main pages that will be displayed in the PageView
  // Ensure these are correctly imported from their respective files
  final List<Widget> _pages = [
    Home(), // Your Home page
    const CategoriesPage(),
    const OrderPage(),
    CartPage(cartItems: const []),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the PageController with the initial selected index
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    // Dispose the PageController when the state is removed to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  // This method is called when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    // Animate the PageView to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300), // Duration of the animation
      curve: Curves.ease, // Animation curve (e.g., ease-in-out)
    );
  }

  // New method to set the selected index from outside this widget
  void setSelectedIndex(int index) {
    _onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // Disable swiping between pages if you only want navigation via bottom nav
        physics: const NeverScrollableScrollPhysics(),
        // Optional: If you enable swiping, this keeps the bottom nav in sync
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages, // The list of pages to display
      ),
      // Assuming 'footer.dart' contains your CustomBottomNav widget
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex, // Pass the current selected index
        onItemTapped: _onItemTapped, // Pass the callback function
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Set MainAppScreen as the home widget and assign the global key.
      // This allows us to access MainAppScreen's state and methods from anywhere.
      home: MainAppScreen(key: mainAppScreenKey),
      // Remove individual routes for bottom nav items from here,
      // as they are now managed by MainAppScreen's PageView.
      // Keep other routes if they are for deep links or other
      // navigation flows not related to the main bottom navigation.
      routes: {
        // Example: If you have a product detail page accessible from other places
        // '/product_detail': (context) => ProductDetailPage(),


      },
    );
  }
}
