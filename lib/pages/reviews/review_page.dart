import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/account/login_page.dart';
import 'package:kebabbo_flutter/pages/reviews/choose_kebab_review_page.dart';
import 'package:kebabbo_flutter/pages/reviews/thankyou_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class ReviewPage extends StatefulWidget {
  final String hash;
  final Position? initialPosition;
  const ReviewPage(
      {super.key, required this.hash, required this.initialPosition});

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
  Position? _currentPosition;
  String _currentHash = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
    changeHash(widget.hash);
  }



Future<void> changeHash(String newHash) async {
  setState(() {
    _currentHash = newHash;
    _isLoading = true; // Start loading
  });
  if (newHash=="nearme"){
      if (mounted) {
        setState(() {
          isValidHash = true;
          _isLoading = false;
        });
      }
    return;
  }
      try {
      final kebabberData = await validateHash(_currentHash);
      if (mounted) {
        setState(() {
          kebabber = kebabberData;
          isValidHash = kebabberData != null;
        });

        if (isValidHash && kebabber != null) {
          await _checkForExistingReview();
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
      var newPost = {
        'user_id': Supabase.instance.client.auth.currentUser?.id,
        'kebab_tag_id': kebabber!['id'],
        'kebab_tag_name': kebabber!['name'],
        'text': S.of(context).reviewMessage(
              kebabber!['name'],
              qualityRating.toString(),
              quantityRating.toString(),
              menuRating.toString(),
              priceRating.toString(),
              funRating.toString(),
              descriptionController.text,
            ),
        'created_at': DateTime.now().toIso8601String(),
      };
      if (existingReview != null) {
        await Supabase.instance.client
            .from('reviews')
            .update(reviewData)
            .eq('id', existingReview!['id']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).review_updated_successfully)),
        );
      } else {
        await Supabase.instance.client.from('reviews').insert(reviewData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).review_submitted_successfully)),
        );
      }
      await Supabase.instance.client.from('posts').insert(newPost);
      await checkAndUpdateMedals(); // Verifica e aggiorna le medaglie
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                S.of(context).unexpected_error_occurred + error.toString())),
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
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('reviews')
          .select()
          .eq('user_id', userId);

      final reviews = response as List<dynamic>;

      if (reviews.isNotEmpty) {
        final profileResponse = await Supabase.instance.client
            .from('profiles')
            .select('medals')
            .eq('id', userId)
            .single();

        final currentMedals = profileResponse['medals'] as List<dynamic>?;
        List<dynamic> updatedMedals = currentMedals ?? [];
        bool newMedalAwarded = false;

        if (!updatedMedals.contains(0)) {
          updatedMedals.add(0);
          newMedalAwarded = true;
        }
        if (reviews.length > 4 && !updatedMedals.contains(1)) {
          updatedMedals.add(1);
          newMedalAwarded = true;
        }
        if (reviews.length > 9 && !updatedMedals.contains(2)) {
          updatedMedals.add(2);
          newMedalAwarded = true;
        }
        if (reviews.length > 19 && !updatedMedals.contains(3)) {
          updatedMedals.add(3);
          newMedalAwarded = true;
        }
        if (reviews.length > 29 && !updatedMedals.contains(4)) {
          updatedMedals.add(4);
          newMedalAwarded = true;
        }

        await Supabase.instance.client
            .from('profiles')
            .update({'medals': updatedMedals}).eq('id', userId);

        if (newMedalAwarded) {
          _showMedalDialog();
        }
      }
    } catch (error) {
      print("Error checking or updating medals: $error");
    }
  }

  void _showMedalDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: S.of(context).nuova_medaglia,
      desc: S.of(context).hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo,
      btnOkOnPress: () {},
      customHeader: Icon(
        Icons.emoji_events,
        color: Colors.amber,
        size: 100,
      )
          .animate(
            onComplete: (controller) => controller.repeat(),
          )
          .scaleXY(
            begin: 0.5,
            end: 1.2,
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticInOut,
          )
          .fadeIn(duration: Duration(milliseconds: 300)),
    ).show();
  }

  // Function to update position
  void updatePosition(Position newPosition) {
    setState(() {
      _currentPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isValidHash) {
      return Scaffold(
        appBar: AppBar(title: Text(S.of(context).review)),
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
                  Text(
                    S.of(context).oops_review_not_found,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S
                        .of(context)
                        .it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    if (kebabber == null) {
      return ChooseReviewPage(
      key:  ValueKey(_currentPosition),
    initialPosition: _currentPosition,
    changeHash: changeHash);
    }
    if (thankYouActive) {
      return ThankYouPage();
    }

    return StreamBuilder<AuthState>(
  stream: supabase.auth.onAuthStateChange,
  builder: (context, snapshot) {
    final session = supabase.auth.currentSession;

    if (session == null && isValidHash) {
      return LoginPage();
    } else {
    return Scaffold(
      appBar: AppBar(
          title: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
          children: [
            TextSpan(text: S.of(context).review),
            TextSpan(
              text: "  ${kebabber?['name'] ?? ""}", // Safe access
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )),
      body:
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            Text(S.of(context).rate_the_kebab,
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
                                          S.of(context).quality,
                                          (rating) => qualityRating = rating,
                                          qualityRating),
                                      const SizedBox(
                                          height: 8), // Small padding
                                      buildCenteredRatingBar(
                                          S.of(context).quantity,
                                          (rating) => quantityRating = rating,
                                          quantityRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          S.of(context).menu,
                                          (rating) => menuRating = rating,
                                          menuRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          S.of(context).price,
                                          (rating) => priceRating = rating,
                                          priceRating),
                                      const SizedBox(height: 8),
                                      buildCenteredRatingBar(
                                          S.of(context).fun,
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
                                          labelText: S.of(context).description,
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(),
                                          errorText:
                                              descriptionController.text.isEmpty
                                                  ? S
                                                      .of(context)
                                                      .description_is_required
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
                                child: Text(S.of(context).submit_review),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(S.of(context).rate_the_kebab,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            buildCenteredRatingBar(
                                S.of(context).quality,
                                (rating) => qualityRating = rating,
                                qualityRating),
                            const SizedBox(height: 8), // Small padding
                            buildCenteredRatingBar(
                                S.of(context).quantity,
                                (rating) => quantityRating = rating,
                                quantityRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar(S.of(context).menu,
                                (rating) => menuRating = rating, menuRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar(S.of(context).price,
                                (rating) => priceRating = rating, priceRating),
                            const SizedBox(height: 8),
                            buildCenteredRatingBar(S.of(context).fun,
                                (rating) => funRating = rating, funRating),
                            const SizedBox(height: 16),
                            TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: S.of(context).description,
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                errorText: descriptionController.text.isEmpty
                                    ? S.of(context).description_is_required
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
                                child: Text(S.of(context).submit_review),
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
  });
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

Future<Map<String, dynamic>?> validateHash(String hash) async {
  // Fetch all names from the kebabbers table
  final List<dynamic> response =
      await Supabase.instance.client.from('kebab').select("name , id");

  // Ensure response is not null or empty
  if (response.isEmpty) {
    print('No data returned from query or error occurred.');
    return null;
  }

  // Iterate through each name, hash it, and check for a match
  for (var row in response) {
    final name = row['name'] as String;
    final nameHash = sha256.convert(utf8.encode(name)).toString();
    // Compare the computed hash with the provided hash
    if (nameHash == hash) {
      return row; // Return the matching row
    }
  }

  // Return null if no match is found
  return null;
}
