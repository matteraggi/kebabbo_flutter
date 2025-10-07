import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item_clickable.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const MAXDISTANCE = 200;

class ChooseReviewPage extends StatefulWidget {
  final Position? initialPosition;
  final Function(String) changeHash;
  const ChooseReviewPage(
      {super.key, required this.initialPosition, required this.changeHash});

  @override
  ChooseReviewState createState() => ChooseReviewState();
}

class ChooseReviewState extends State<ChooseReviewPage> {
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

  void _refreshPage() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      _fetchKebabNearMe(_currentPosition);
    }
  }

  Future<void> _fetchKebabNearMe(Position? userPosition) async {
    if (userPosition == null) {
      if (mounted) {
        setState(() => isLoading = false);
      }
      return;
    }

    try {
      final PostgrestList response = await supabase.from('kebab').select('*');
      if (!mounted) return;

      List<Map<String, dynamic>> kebabs = List<Map<String, dynamic>>.from(response);
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
          filteredKebabs.add(kebab);
        }
      }

      setState(() {
        dashList = filteredKebabs;
        isLoading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
          isLoading = false;
        });
      }
    }
  }

  // NEW: A dedicated widget for when permission is needed.
  Widget _buildPermissionNeededUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Location permission is needed to find places near you.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // NEW: A dedicated widget for when there are no results.
  Widget _buildNoResultsUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).nessun_kebab_vicino_a_te,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: red,
            ),
            onPressed: _refreshPage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.refresh, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Retry",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                  // CHANGED: Check if position is null to decide which message to show.
                  ? _currentPosition == null
                      ? _buildPermissionNeededUI() // Show this if location was denied.
                      : _buildNoResultsUI() // Show this if location is on but no results.
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