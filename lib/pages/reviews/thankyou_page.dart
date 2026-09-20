import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';

import 'package:kebabbo_flutter/components/misc/medal_popup.dart';

class ThankYouPage extends StatefulWidget {
  final bool newMedalEarned;
  const ThankYouPage({super.key, this.newMedalEarned = false});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  void initState() {
    super.initState();
    if (widget.newMedalEarned) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showMedalDialog(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).thank_you),
        centerTitle: true,
        backgroundColor: red, // Adjust the app bar color
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100, // Add an icon for visual appeal
              ),
              const SizedBox(height: 24), // Space between the icon and text
              Text(
                S.of(context).thank_you_for_your_review,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Text color
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S
                    .of(context)
                    .you_can_access_reviews_at_any_time_from_your_account,
                textAlign: TextAlign.center, // Center-align the text
                style: TextStyle(
                  fontSize: 18,
                  color:
                      Colors.black54, // Slightly muted color for secondary text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
