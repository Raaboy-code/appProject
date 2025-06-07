import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Info
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image asset or NetworkImage
            ),
            const SizedBox(height: 10),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'johndoe@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              '+855 123 456 789',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Menu Options
            const Divider(),
            _buildMenuItem(context, Icons.shopping_bag, 'My Orders', () {
              // Navigate to My Orders
            }),
            _buildMenuItem(context, Icons.favorite, 'Wishlist', () {
              // Navigate to Wishlist
            }),
            _buildMenuItem(context, Icons.history, 'Browsing History', () {
              // Navigate to History
            }),
            _buildMenuItem(context, Icons.settings, 'Settings', () {
              // Navigate to Settings
            }),
            _buildMenuItem(context, Icons.help_outline, 'Help & Support', () {
              // Navigate to Support
            }),
            const Divider(),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Logout', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Handle logout logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
