import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

// Gli indirizzi dei link condivisi dall'app devono coincidere con quelli
// delle pagine web (seo/lib.mjs). Valori generati dal server per i nomi reali.
void main() {
  const expected = <String, String>{
    'Agra': 'agra',
    'Ali Baba Food House': 'ali-baba-food-house',
    'Baba Turkish': 'baba-turkish',
    'Babilonia Kebab': 'babilonia-kebab',
    'Baris Grillhaus (HAM)': 'baris-grillhaus-ham',
    'Beirut Snack': 'beirut-snack',
    'Bella Istanbul 3': 'bella-istanbul-3',
    'Birdies (StA)': 'birdies-sta',
    'Bologna Barbecue': 'bologna-barbecue',
    'Caldi e Freddi (AM)': 'caldi-e-freddi-am',
    'Chicken & Kebab 786': 'chicken-e-kebab-786',
    'Ciao Kebab': 'ciao-kebab',
    'Delizioso Food': 'delizioso-food',
    'Deniz Kebab (TOULOUSE)': 'deniz-kebab-toulouse',
    'Dr Jimmy': 'dr-jimmy',
    'Dumanaltı kebap': 'dumanalti-kebap',
    'Ekopollo': 'ekopollo',
    'Galata Tantuni & künefe': 'galata-tantuni-e-kunefe',
    'Gli Scugnizzi': 'gli-scugnizzi',
    'Heights Falafel': 'heights-falafel',
    'I Panini di Mirò': 'i-panini-di-miro',
    'Juicy Kebab (AM)': 'juicy-kebab-am',
    'Kebab and Tandoor (ROMA)': 'kebab-and-tandoor-roma',
    'Kebab di renna (HELSINKI)': 'kebab-di-renna-helsinki',
    'Mangio Pizza Kebab': 'mangio-pizza-kebab',
    'Mehas Doner (BER)': 'mehas-doner-ber',
    'Mundis Kebap (BER)': 'mundis-kebap-ber',
    'Murgulet Kebab': 'murgulet-kebab',
    'Mustafa\'s Can Gemüse (BER)': 'mustafas-can-gemuse-ber',
    'Nemrut doner': 'nemrut-doner',
    'Nosadella Pizza Kebab': 'nosadella-pizza-kebab',
    'Pamcial': 'pamcial',
    'Parsit': 'parsit',
    'Pizza BAKI': 'pizza-baki',
    'Pizza e Kebab (CERVIA)': 'pizza-e-kebab-cervia',
    'Pizza Instanbul Kepap (VALDAGNO)': 'pizza-instanbul-kepap-valdagno',
    'Pizza N Pizza': 'pizza-n-pizza',
    'Pizza Viva Express': 'pizza-viva-express',
    'Pizzeria Chicco': 'pizzeria-chicco',
    'Pizzeria Girasole': 'pizzeria-girasole',
    'Professorn (STHML)': 'professorn-sthml',
    'Route 66': 'route-66',
    'Salt and Peppers': 'salt-and-peppers',
    'Ses Doner (AIA)': 'ses-doner-aia',
    'Sham cibo siriano': 'sham-cibo-siriano',
    'StA Shawarma House (StA)': 'sta-shawarma-house-sta',
    'Ster Kebab (ZOET)': 'ster-kebab-zoet',
    'Taj Mahal': 'taj-mahal',
    'Tasty Fast Food Crepes Ipsos (CORFU)': 'tasty-fast-food-crepes-ipsos-corfu',
    'Tavernaki': 'tavernaki',
    'To Steki': 'to-steki',
  };

  test('kebabSlug matches the website slug for every kebab', () {
    expected.forEach((name, slug) => expect(kebabSlug(name), slug, reason: name));
  });
}
