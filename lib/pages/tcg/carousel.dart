import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/pages/tcg/rotation_scene_v1.dart';
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
      final response = await supabase.from('reviews').select('kebabber_id');

      setState(() {
        imagePaths = response.map<String>((review) {
          final kebabberId = review['kebabber_id'];
          return 'assets/kebab-card/$kebabberId.png';
        }).toList();
        imagePaths = [
          "assets/kebab-card/agra.png",
          "assets/kebab-card/agra.png",
          "assets/kebab-card/agra.png",
          "assets/kebab-card/agra.png",
          "assets/kebab-card/agra.png",
        ];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebab TCG Carousel'),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imagePaths.isEmpty
              ? const Center(child: Text('No reviews found'))
              : RotationSceneV1(imagePaths: imagePaths),
    );
  }
}
