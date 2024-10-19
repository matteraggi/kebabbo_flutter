import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/card_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final matteraggiUrls = [
  Uri.parse("https://www.instagram.com/matteraggiii"),
  Uri.parse("https://www.linkedin.com/in/matteo-raggi"),
  Uri.parse("https://www.github.com/matteraggi"),
  Uri.parse("https://github.com/matteraggi")
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
