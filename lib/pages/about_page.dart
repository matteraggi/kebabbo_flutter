import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/card_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Text(
                'La tua soluzione per il pranzo universitario',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 20),
              Text(
                "In Italia il mondo del Kebab è ancora un mondo oscuro. I migliori locali sono sottovalutati, e i peggiori ricevono recensioni alte su Google.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text(
                "Per questo ci siamo noi: studenti universitari, come voi, con anni di esperienza come mangiatori di Kebab.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text(
                "Testiamo e recensiamo Kebabbari e Street Food per voi. Benvenuti su Kebabbo.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.euro, color: Colors.black, size: 40),
                      ),
                      SizedBox(height: 8),
                      Text(
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.bolt, color: Colors.black, size: 40),
                      ),
                      SizedBox(height: 8),
                      Text(
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.restaurant,
                            color: Colors.black, size: 40),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'tasty',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardItem(
                    image: 'assets/images/matteo.jpg',
                    name: 'Matteo',
                    description: 'Developer & Eater',
                    icons: [
                      FontAwesomeIcons.instagram,
                      FontAwesomeIcons.linkedin,
                      FontAwesomeIcons.github,
                      FontAwesomeIcons.google,
                    ],
                    url: [
                      Uri.parse("https://www.instagram.com/matteraggiii"),
                      Uri.parse("https://www.linkedin.com/in/matteo-raggi"),
                      Uri.parse("https://www.github.com/matteraggi"),
                      Uri.parse("https://github.com/matteraggi")
                    ],
                  ),
                  CardItem(
                    image: 'assets/images/frigo.jpg',
                    name: 'Elia',
                    description: 'Developer & Eater',
                    icons: [
                      FontAwesomeIcons.instagram,
                      FontAwesomeIcons.linkedin,
                      FontAwesomeIcons.github
                    ],
                    url: [
                      Uri.parse("https://www.instagram.com/eliafriberg"),
                      Uri.parse(
                          "https://www.linkedin.com/in/elia-friberg-021a90295"),
                      Uri.parse("https://www.github.com/fri3erg")
                    ],
                  ),
                  CardItem(
                    image: 'assets/images/fra.jpg',
                    name: 'Francesco',
                    description: 'Social Media Manager',
                    icons: [
                      FontAwesomeIcons.instagram,
                      FontAwesomeIcons.github
                    ],
                    url: [
                      Uri.parse("https://www.instagram.com/fra___espo"),
                      Uri.parse("https://www.github.com/Francesco0905")
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
