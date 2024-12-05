import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/card_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';

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
class AboutPage extends StatefulWidget {
  const AboutPage({super.key}); // Super parameter for key

  @override
  AboutPageState createState() => AboutPageState(); // Public state class
}
class AboutPageState extends State<AboutPage> {
  void _showSuggestionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final TextEditingController kebabNameController = TextEditingController();

        return AlertDialog(
          title: Text( S.of(context).consigliaci_un_kebabbaro),
          content: TextField(
            controller: kebabNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: S.of(context).nome_del_kebabbaro,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text(S.of(context).annulla),
            ),
            ElevatedButton(
              onPressed: () async {
                String kebabName = kebabNameController.text;

                // Close the dialog before starting the async operation
                Navigator.of(dialogContext).pop();

                // Perform the async email operation
                await sendEmail(kebabName);
              },
              child: Text(S.of(context).invia),
            ),
          ],
        );
      },
    );
  }
  Future<void> sendEmail(String kebabName) async {
    const serviceId = 'service_60j6i59';
    const templateId = 'template_3w34spe';
    const userId = 'X8vOilcepKloZtdAE';

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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
               Text(
                S.of(context).la_tua_soluzione_per_il_pranzo_universitario,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
               Text(
                S.of(context).per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo,
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    S.of(context).consigliaci_un_kebabbaro,
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
