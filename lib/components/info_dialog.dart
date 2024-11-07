// Function to show the info dialog
import 'package:flutter/material.dart';

void showInfoDialog(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

// The "i" circular button widget
Widget buildInfoButton(BuildContext context, String title, String description) {
  return FloatingActionButton(
    backgroundColor: Colors.blue, // Customize the color as needed
    child: const Icon(Icons.info_outline),
    onPressed: () {
      showInfoDialog(context, title, description);
    },
  );
}