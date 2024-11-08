import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/kebab_item_favorite.dart';

class ThankYouPage extends StatelessWidget {
  
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You'),
        centerTitle: true,
        backgroundColor: red, // Adjust the app bar color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100, // Add an icon for visual appeal
              ),
              const SizedBox(height: 24), // Space between the icon and text
              const Text(
                'Thank you for your review!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Text color
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You can access reviews at any time from your account.',
                textAlign: TextAlign.center, // Center-align the text
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.black54, // Slightly muted color for secondary text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
