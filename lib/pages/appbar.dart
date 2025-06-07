import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final int notificationCount;

  const CustomAppBar({
    super.key,
    required this.name,
    this.notificationCount = 0, // default 0
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Electronic App',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Icons row
          Row(
            children: [
              const Icon(Icons.shopping_cart_outlined, size: 28),
              const SizedBox(width: 16),

              // Notification icon with badge
              Stack(
                children: [
                  const Icon(Icons.notifications_none_outlined, size: 30),
                  if (notificationCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Text(
                          notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 16),

              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/Profile.jpg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
