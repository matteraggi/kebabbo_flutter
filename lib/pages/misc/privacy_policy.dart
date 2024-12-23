import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  Future<String> loadHtmlFromAssets(String path) async {
    return await rootBundle.loadString(path);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: FutureBuilder(
        future: loadHtmlFromAssets('privacy-policy/index.html'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, // Enable vertical scrolling
                child: Container(
                  width: MediaQuery.of(context).size.width * 2, // Adjust width as needed
                  padding: const EdgeInsets.all(16.0),
                  child: Html(data: snapshot.data as String),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}