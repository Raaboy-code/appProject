import 'package:flutter/material.dart';

class BrandDetailsPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const BrandDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['name'])),
      body: Center(
        child: Icon(item['icon'], size: 100, color: Colors.blue),
      ),
    );
  }
}
