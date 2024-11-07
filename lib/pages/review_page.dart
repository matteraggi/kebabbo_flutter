import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kebabbo_flutter/components/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewPage extends StatefulWidget {
  final String hash; // Passed from the URL hash verification
  
  const ReviewPage({super.key, required this.hash});
  
  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  double qualityRating = 0;
  double quantityRating = 0;
  double menuRating = 0;
  double priceRating = 0;
  double funRating = 0;
  final TextEditingController descriptionController = TextEditingController();
  bool isValidHash = false;
  Map<String, dynamic>? kebabber;

  @override
  void initState() {
    super.initState();
    _validateHash();
  }

  Future<void> _validateHash() async {
    final kebabberData = await validateHash(widget.hash);
    if (mounted) {
      setState(() {
        kebabber = kebabberData;
        isValidHash = kebabberData != null;
      });
    }
  }

  Future<void> submitReview() async {
    if (!isValidHash || kebabber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid hash")),
      );
      return;
    }
    print(kebabber);
    final reviewData = {
      'kebabber_id': kebabber!['id'],
      'quality': qualityRating,
      'quantity': quantityRating,
      'menu': menuRating,
      'price': priceRating,
      'fun': funRating,
      'description': descriptionController.text,
      'created_at': DateTime.now().toIso8601String(),
      'user_id': Supabase.instance.client.auth.currentUser?.id,
    };

    try {
      final response = await Supabase.instance.client
          .from('reviews')
          .insert(reviewData)
          .select();

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review submitted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Failed to submit review")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $error")),
      );
    }
  }

@override
Widget build(BuildContext context) {
  if (!isValidHash || kebabber == null) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
                const SizedBox(height: 16),
                const Text(
                  'Oops! Review Not Found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'It looks like the review you are trying to access does not exist. Please check the link and try again.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  if (Supabase.instance.client.auth.currentSession == null) {
    return Scaffold(
      appBar: AppBar(title: Text('Review ${kebabber!['name']}')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please Log In to Submit Your Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Scaffold(
    appBar: AppBar(title: Text('Review ${kebabber!['name']}')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;

                return isWideScreen
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Rate the Kebab', style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    buildCenteredRatingBar('Quality', (rating) => qualityRating = rating),
                                    buildCenteredRatingBar('Quantity', (rating) => quantityRating = rating),
                                    buildCenteredRatingBar('Menu', (rating) => menuRating = rating),
                                    buildCenteredRatingBar('Price', (rating) => priceRating = rating),
                                    buildCenteredRatingBar('Fun', (rating) => funRating = rating),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                        labelText: 'Description',
                                        border: OutlineInputBorder(),
                                      ),
                                      maxLines: 8, // Taller textbox for desktop
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: ElevatedButton(
                              onPressed: submitReview,
                              child: const Text('Submit Review'),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const Text('Rate the Kebab', style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 16),
                          buildCenteredRatingBar('Quality', (rating) => qualityRating = rating),
                          buildCenteredRatingBar('Quantity', (rating) => quantityRating = rating),
                          buildCenteredRatingBar('Menu', (rating) => menuRating = rating),
                          buildCenteredRatingBar('Price', (rating) => priceRating = rating),
                          buildCenteredRatingBar('Fun', (rating) => funRating = rating),
                          const SizedBox(height: 16),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 5,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: submitReview,
                              child: const Text('Submit Review'),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    ),
  );
}


Widget buildCenteredRatingBar(String label, Function(double) onRatingUpdate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(label, textAlign: TextAlign.center),
      RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: yellow,
        ),
        onRatingUpdate: onRatingUpdate,
      ),
    ],
  );
}
}

String generateHash(String kebabberName) {
  final bytes = utf8.encode(kebabberName);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<Map<String, dynamic>?> validateHash(String hash) async {
  // Fetch all names from the kebabbers table
  final List<dynamic>? response = await Supabase.instance.client
      .from('kebab')
      .select("name , id");

  // Ensure response is not null or empty
  if (response == null || response.isEmpty) {
    print('No data returned from query or error occurred.');
    return null;
  }

  // Iterate through each name, hash it, and check for a match
  for (var row in response) {
    final name = row['name'] as String;
    final nameHash = sha256.convert(utf8.encode(name)).toString();
    print('Name: $name, Hash: $nameHash');
    // Compare the computed hash with the provided hash
    if (nameHash == hash) {
      return row; // Return the matching row
    }
  }

  // Return null if no match is found
  return null;
}
