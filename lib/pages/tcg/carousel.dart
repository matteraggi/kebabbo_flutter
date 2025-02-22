import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/pages/tcg/rotation_scene_v1.dart';
import 'package:kebabbo_flutter/pages/tcg/single_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KebabCarouselPage extends StatefulWidget {
  const KebabCarouselPage({super.key});

  @override
  State<KebabCarouselPage> createState() => _KebabCarouselPageState();
}

class _KebabCarouselPageState extends State<KebabCarouselPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = true;
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final response = await supabase.from('profiles').select('tcg').eq(
          'id',
          supabase.auth.currentUser?.id ?? ""); // Fetch current user's tcg list

      if (response.isNotEmpty) {
        final List<int> tcgIds = List<int>.from(
            response[0]['tcg']); // Get list of ids from "tcg" column
        print('tcgIds: $tcgIds');
        if (tcgIds.isNotEmpty) {
          // Fetch the names from "kebab" table where the "id" is in the list of tcgIds
          final kebabResponse = await supabase
              .from('kebab')
              .select('name')
              .filter('id', 'in', tcgIds);
          print('kebabResponse: $kebabResponse');
          setState(() {
            imagePaths = kebabResponse.map<String>((kebabs) {
              final String kebabberId =
                  kebabs['name'].toLowerCase().replaceAll(' ', '-');
              return 'assets/kebab-card/$kebabberId.png';
            }).toList();
          });
        }
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
    finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).my_cards),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imagePaths.isEmpty
              ? Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(S.of(context).no_cards_yet),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PackPage()),
                  );
                },
                child: Text(S.of(context).go_back),
              ),
            ],
          ))
              : imagePaths.length==1?
                SingleCard(imagePath: imagePaths[0]):
                RotationSceneV1(imagePaths: imagePaths),
    );
  }
}
