// Function to show the info dialog
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';

void showInfoDialog(BuildContext context, String title, String description) {
  showKebabboDialog(
    context,
    title: title,
    description: description,
    header: const Icon(Icons.info_outline, color: red, size: 100),
  );
}

// The "i" circular button widget
Widget buildInfoButton(
    BuildContext context, String title, String description, Color col) {
  return IconButton(
    icon: Icon(Icons.info_outline, color: col, size: 30),
    onPressed: () {
      showInfoDialog(context, title, description);
    },
  );
}

Widget textExplanation(BuildContext context, String text) {
  return Center(
    // Center the text within the available space
    child: Column(
      mainAxisSize:
          MainAxisSize.min, // Use min to only take needed vertical space
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        linkExplanation(context),
      ],
    ),
  );
}

Widget linkExplanation(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showInfoDialog(context, S.of(context).popup_title,
          S.of(context).popup_description); // Function to show the popup
    },
    child: Text(
      S.of(context).more_info, // Localized string for 'More Info'
      style: TextStyle(
        color: Colors.blue, // Underlined and styled text
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
