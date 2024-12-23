import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  Future<String> loadHtmlFromAssets(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      debugPrint("Errore nel caricamento dell'HTML: $e");
      return "<h1>Errore nel caricamento della Privacy Policy</h1>";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: FutureBuilder(
        future: loadHtmlFromAssets('assets/privacy-policy/index.html'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Errore nel caricamento della Privacy Policy',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Html(
                  data: snapshot.data as String,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
