import 'package:flutter/material.dart';

class PopupKebabItem extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;

  const PopupKebabItem({
    required this.name,
    required this.description,
    required this.rating,
    required this.quality,
    required this.price,
    required this.dimension,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 250, // Limita la larghezza del popup
            maxHeight: 300, // Limita l'altezza del popup
          ),
          child: SingleChildScrollView(
            // Aggiunge uno scroll in caso di contenuto eccessivo
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8), // Spaziatura tra i testi
                Text(description, style: TextStyle(fontSize: 14)),
                Divider(), // Linea divisoria
                Text('Rating: $rating', style: TextStyle(fontSize: 14)),
                Text('Quality: $quality', style: TextStyle(fontSize: 14)),
                Text('Price: $price', style: TextStyle(fontSize: 14)),
                Text('Dimension: $dimension', style: TextStyle(fontSize: 14)),
                Text('Menu: $menu', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
