import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kebabbo_flutter/components/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/thankyou_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewPage extends StatefulWidget {
  final String hash;
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
  Map<String, dynamic>? existingReview;
  final redirectUrl = Uri.base.toString();
  bool isSubmitting = false;
  bool thankYouActive = false;

  @override
  void initState() {
    super.initState();
    _validateHash();
    descriptionController.addListener(() {
      setState(() {}); // Rebuild UI whenever the description changes
    });
  }

  Future<void> _validateHash() async {
    final kebabberData = await validateHash(widget.hash);
    if (mounted) {
      setState(() {
        kebabber = kebabberData;
        isValidHash = kebabberData != null;
      });

      if (isValidHash && kebabber != null) {
        await _checkForExistingReview();
      }
    }
  }

  Future<void> _checkForExistingReview() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null || kebabber == null) return;

    final response = await Supabase.instance.client
        .from('reviews')
        .select()
        .eq('user_id', userId)
        .eq('kebabber_id', kebabber!['id'])
        .maybeSingle(); // Retrieve single review or null

    print('response: $response');
    if (response != null) {
      setState(() {
        existingReview = response;
        qualityRating = response['quality'];
        quantityRating = response['quantity'];
        menuRating = response['menu'];
        priceRating = response['price'];
        funRating = response['fun'];
        descriptionController.text = response['description'];
      });
    }
  }

  Future<void> submitReview() async {
    setState(() {
      isSubmitting = true;
    });

    if (!isValidHash || kebabber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid hash")),
      );
      return;
    }

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
      if (existingReview != null) {
        print('existingReview: $existingReview');
        print('reviewData: $reviewData');
        // Update existing review
        await Supabase.instance.client
            .from('reviews')
            .update(reviewData)
            .eq('id', existingReview!['id']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review updated successfully")),
        );
      } else {
        // Insert new review
        await Supabase.instance.client.from('reviews').insert(reviewData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review submitted successfully")),
        );
      }

      // Call the function to check and update medals
      await checkAndUpdateMedals();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $error")),
      );
    } finally {
      setState(() {
        isSubmitting = false;
        thankYouActive = true;
      });
    }
  }

  Future<void> checkAndUpdateMedals() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      return; // No user is logged in
    }

    try {
      // Count the number of reviews by the current user
      final response = await Supabase.instance.client
          .from('reviews')
          .select()
          .eq('user_id', userId);

      final reviews = response as List<dynamic>;

      if (reviews.length > 0) {
        // Retrieve the current 'medals' array from the user's profile
        final profileResponse = await Supabase.instance.client
            .from('profiles')
            .select('medals')
            .eq('user_id', userId)
            .single();

        final currentMedals = profileResponse['medals'] as List<dynamic>?;
        List<dynamic> updatedMedals = currentMedals ?? [];

        // Check if the user has more than 1 review
        if (!updatedMedals.contains(0)) {
          updatedMedals.add(0);
        }
        if (reviews.length > 4 && !updatedMedals.contains(1)) {
          updatedMedals.add(1);
        }
        if (reviews.length > 9 && !updatedMedals.contains(2)) {
          updatedMedals.add(2);
        }
        if (reviews.length > 19 && !updatedMedals.contains(3)) {
          updatedMedals.add(3);
        }
        if (reviews.length > 29 && !updatedMedals.contains(4)) {
          updatedMedals.add(4);
        }
        await Supabase.instance.client
            .from('profiles')
            .update({'medals': updatedMedals}).eq('user_id', userId);
      }
    } catch (error) {
      print("Error checking or updating medals: $error");
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
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.red, size: 50),
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
        appBar: AppBar(
            title: RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 18.0, color: Colors.black), // Base style
            children: [
              const TextSpan(text: 'Review '), // Regular text
              TextSpan(
                text: kebabber!['name'], // The name
                style: const TextStyle(
                  fontSize: 22.0, // Make the name bigger
                  fontWeight: FontWeight.bold, // Make the name bold
                ),
              ),
            ],
          ),
        )),
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
                  GoogleLoginButton(redirectUrl: redirectUrl),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (thankYouActive) {
      return ThankYouPage();
    }

    return Scaffold(
      appBar: AppBar(
          title: RichText(
        text: TextSpan(
          style: const TextStyle(
              fontSize: 18.0, color: Colors.black), // Base style
          children: [
            const TextSpan(text: 'Review '), // Regular text
            TextSpan(
              text: kebabber!['name'], // The name
              style: const TextStyle(
                fontSize: 22.0, // Make the name bigger
                fontWeight: FontWeight.bold, // Make the name bold
              ),
            ),
          ],
        ),
      )),
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
                            const Text('Rate the Kebab',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      buildCenteredRatingBar(
                                          'Quality',
                                          (rating) => qualityRating = rating,
                                          qualityRating),
                                      const SizedBox(
                                          height: 8), // Small padding
                                      buildCenteredRatingBar(
                                          'Quantity',
                                          (rating) => quantityRating = rating,
                                          quantityRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          'Menu',
                                          (rating) => menuRating = rating,
                                          menuRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          'Price',
                                          (rating) => priceRating = rating,
                                          priceRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          'Fun',
                                          (rating) => funRating = rating,
                                          funRating),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                          labelText: 'Description',
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(),
                                          errorText:
                                              descriptionController.text.isEmpty
                                                  ? 'Description is required'
                                                  : null, // Show error if empty
                                        ),
                                        maxLines:
                                            8, // Taller textbox for desktop
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: ElevatedButton(
                                onPressed: isSubmitting ||
                                        descriptionController.text.isEmpty
                                    ? null
                                    : submitReview,
                                child: const Text('Submit Review'),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Text('Rate the Kebab',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            buildCenteredRatingBar(
                                'Quality',
                                (rating) => qualityRating = rating,
                                qualityRating),
                            const SizedBox(height: 8), // Small padding
                            buildCenteredRatingBar(
                                'Quantity',
                                (rating) => quantityRating = rating,
                                quantityRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar('Menu',
                                (rating) => menuRating = rating, menuRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar('Price',
                                (rating) => priceRating = rating, priceRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar('Fun',
                                (rating) => funRating = rating, funRating),
                            const SizedBox(height: 16),
                            TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                errorText: descriptionController.text.isEmpty
                                    ? 'Description is required'
                                    : null, // Show error if empty
                              ),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: isSubmitting ||
                                        descriptionController.text.isEmpty
                                    ? null
                                    : submitReview,
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

  Widget buildCenteredRatingBar(
      String label, Function(double) onRatingUpdate, double initialRating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        RatingBar.builder(
          initialRating: initialRating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: yellow,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
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
  final List<dynamic> response = await Supabase.instance.client
      .from('kebab')
      .select("name , id");

  // Ensure response is not null or empty
  if (response.isEmpty) {
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
