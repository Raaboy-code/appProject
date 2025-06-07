//
// import 'package:flutter/material.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   const CustomBottomNav({super.key});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         Navigator.pushNamed(context, '/home');
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/categories');
//         break;
//       case 2:
//         Navigator.pushNamed(context, '/order');
//         break;
//       case 3:
//         Navigator.pushNamed(context, '/cart');
//         break;
//       case 4:
//         Navigator.pushNamed(context, '/profile');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.grey,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.category_outlined),
//           label: 'Categories',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_bag_outlined),
//           label: 'Order',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart_outlined),
//           label: 'Cart',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_outline),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
//
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  // Define the required parameters for the constructor
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex, // Mark as required
    required this.onItemTapped, // Mark as required
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_copy_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
