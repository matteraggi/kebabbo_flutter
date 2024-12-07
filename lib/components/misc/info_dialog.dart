// Function to show the info dialog
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';

 void showInfoDialog(BuildContext context, String title, String description) {
  AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkColor: red,
      btnOkOnPress: () {},
      customHeader: Icon(
      Icons.info_outline,
      color: red,
      size: 100,
    )  // No animation for the image
    ).show();
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
  return Expanded(
      // Expanded to take up all available vertical space
      child: Center(
    // Center the text
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        linkExplanation(context)
      ],
    ),
  ));
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
