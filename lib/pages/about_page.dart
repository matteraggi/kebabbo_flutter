import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/card_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kebabbo_flutter/main.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

final matteraggiUrls = [
  Uri.parse("https://www.instagram.com/matteraggiii"),
  Uri.parse("https://www.linkedin.com/in/matteo-raggi"),
  Uri.parse("https://www.github.com/matteraggi"),
  Uri.parse("https://www.matteoraggiblog.com")
];

final eliaUrls = [
  Uri.parse("https://www.instagram.com/eliafriberg"),
  Uri.parse("https://www.linkedin.com/in/elia-friberg-021a90295"),
  Uri.parse("https://www.github.com/fri3erg")
];

final francescoUrls = [
  Uri.parse("https://www.instagram.com/fra___espo"),
  Uri.parse("https://www.github.com/Francesco0905")
];

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _showSuggestionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController kebabNameController =
            TextEditingController(); // Controller per il campo di testo

        return AlertDialog(
          title: const Text("Consigliaci un kebabbaro"),
          content: TextField(
            controller: kebabNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome del kebabbaro',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiude il dialog
              },
              child: const Text("Annulla"),
            ),
            ElevatedButton(
              onPressed: () async {
                String kebabName = kebabNameController.text;
                await sendEmail(kebabName); // Invia l'email
                Navigator.of(context).pop(); // Chiude il dialog
              },
              child: const Text("Invia"),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendEmail(String kebabName) async {
    const serviceId = 'service_60j6i59'; // ID del servizio EmailJS
    const templateId = 'template_3w34spe'; // ID del template EmailJS
    const userId = 'X8vOilcepKloZtdAE'; // ID utente EmailJS

    // Corpo della richiesta POST
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {'message': kebabName},
      }),
    );

    if (response.statusCode == 200) {
      print('Email inviata con successo!');
    } else {
      print('Errore nell\'invio dell\'email: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const Text(
                'La tua soluzione per il pranzo universitario',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              const Text(
                "In Italia il mondo del Kebab è ancora un mondo oscuro. I migliori locali sono sottovalutati, e i peggiori ricevono recensioni alte su Google.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              const Text(
                "Per questo ci siamo noi: studenti universitari, come voi, con anni di esperienza come mangiatori di Kebab.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              const Text(
                "Testiamo e recensiamo Kebabbari e Street Food per voi. Benvenuti su Kebabbo.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.euro,
                            color: Colors.black, size: 40),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'cheap',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.bolt,
                            color: Colors.black, size: 40),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'fast',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.restaurant,
                            color: Colors.black, size: 40),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'tasty',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showSuggestionForm(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(
                        12), // Arrotondamento degli angoli
                  ),
                  child: const Text(
                    "Consigliaci un kebabbaro",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 900) {
                    // Adjust threshold as needed
                    // Enough space for a row
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardItem(
                            image: 'assets/images/matteo.jpg',
                            name: 'Matteo',
                            description: 'Developer & Eater',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.linkedin,
                              FontAwesomeIcons.github,
                              FontAwesomeIcons.google,
                            ],
                            url: matteraggiUrls),
                        CardItem(
                            image: 'assets/images/frigo.jpg',
                            name: 'Elia',
                            description: 'Developer & Eater',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.linkedin,
                              FontAwesomeIcons.github
                            ],
                            url: eliaUrls),
                        CardItem(
                            image: 'assets/images/fra.jpg',
                            name: 'Francesco',
                            description: 'Social Media Manager',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.github
                            ],
                            url: francescoUrls),
                      ],
                    );
                  } else {
                    // Not enough space, use a column
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CardItem(
                            image: 'assets/images/matteo.jpg',
                            name: 'Matteo',
                            description: 'Developer & Eater',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.linkedin,
                              FontAwesomeIcons.github,
                              FontAwesomeIcons.google,
                            ],
                            url: matteraggiUrls),
                        CardItem(
                            image: 'assets/images/frigo.jpg',
                            name: 'Elia',
                            description: 'Developer & Eater',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.linkedin,
                              FontAwesomeIcons.github
                            ],
                            url: eliaUrls),
                        CardItem(
                            image: 'assets/images/fra.jpg',
                            name: 'Francesco',
                            description: 'Social Media Manager',
                            icons: const [
                              FontAwesomeIcons.instagram,
                              FontAwesomeIcons.github
                            ],
                            url: francescoUrls),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
