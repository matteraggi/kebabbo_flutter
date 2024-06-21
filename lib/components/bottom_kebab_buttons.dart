import 'package:flutter/material.dart';

class BottomButtonItem extends StatefulWidget {
  final String linkMaps;

  BottomButtonItem({
    required this.linkMaps,
  });

  @override
  _BottomButtonItemState createState() => _BottomButtonItemState();
}

class _BottomButtonItemState extends State<BottomButtonItem> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: () {
          print('Navigating to ${widget.linkMaps}');
          //fare navigazione
        },
        child: Row(
          mainAxisSize: MainAxisSize.min, // Aggiungere questa riga
          children: [
            Icon(Icons.navigation, color: Colors.white, size: 16),
            SizedBox(width: 5), // Spazio tra l'icona e il testo
            Text(
              'Google Maps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
