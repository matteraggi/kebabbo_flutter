import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item_clickable.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const MAXDISTANCE = 200000;

class ChooseReviewPage extends StatefulWidget {
  final Position? initialPosition;
  final Function(String) changeHash;
  const ChooseReviewPage({super.key, required this.initialPosition, required this.changeHash});

  @override
  ChooseReviewState createState() => ChooseReviewState();
}

class ChooseReviewState extends State<ChooseReviewPage> {
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = true;
  String? errorMessage;
  List<Map<String, dynamic>> dashList = [];
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
    _fetchKebabNearMe(_currentPosition);
  }
Future<void> _fetchKebabNearMe(Position? userPosition) async {
  final PostgrestList response = await supabase.from('kebab').select('*');
  try {
    if (userPosition == null) {
      setState(() {
        isLoading = true;
      });
      return;
    }
    if (mounted) {
      List<Map<String, dynamic>> kebabs =
          List<Map<String, dynamic>>.from(response as List);

      List<Map<String, dynamic>> filteredKebabs = [];

      for (var kebab in kebabs) {
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          kebab['lat'] ?? 0.0,
          kebab['lng'] ?? 0.0,
        );
        kebab['distance'] = distanceInMeters / 1000;

        if (distanceInMeters <= MAXDISTANCE) {
          // Add kebab to filtered list if within max distance
          filteredKebabs.add(kebab);
        } else {
        }
      }

      // Update state with filtered kebabs
      setState(() {
        dashList = filteredKebabs;
        isLoading = false;
      });
    }
  } catch (error) {
    if (mounted) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : dashList.isEmpty
                  ? Center(
                      child: Text(S.of(context).nessun_kebab_vicino_a_te),
                    )
                  : ListView.builder(
                      itemCount: dashList.length,
                      itemBuilder: (context, index) {
                        final kebab = dashList[index];
                        return KebabListItemClickable(
                          id: kebab['id'].toString(),
                          name: kebab['name'] ?? '',
                          rating: (kebab['rating'] ?? 0.0).toDouble(),
                          tag: (kebab['tag'] ?? ''),
                          isOpen: kebab['isOpen'] ?? false,
                          glutenFree: kebab['gluten_free'] ?? false,
                          onKebabSelected: (selectedKebabId) {
                            widget.changeHash(generateHash(kebab['name']));
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
