import 'package:flutter/material.dart';

class PackPage extends StatefulWidget {
  const PackPage({super.key});

  @override
  PackPageState createState() => PackPageState();
}

class PackPageState extends State<PackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pack")),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Angoli arrotondati
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Colore ombra
                spreadRadius: 1, // Diffusione ombra
                blurRadius: 10, // Sfocatura ombra
                offset: Offset(5, 5), // Posizione dell'ombra (x, y)
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16), // Angoli immagine arrotondati
            child: Image.asset(
              'assets/images/kebabbo_pack.png', // Percorso dell'immagine
              width: 300,
              height: 600,
              fit: BoxFit.cover, // Adatta l'immagine al contenitore
            ),
          ),
        ),
      ),
    );
  }
}
