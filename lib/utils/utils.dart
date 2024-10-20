import 'package:fuzzy/fuzzy.dart';
import 'package:geolocator/geolocator.dart';

List<Map<String, dynamic>> fuzzySearchAndSort(
    List<Map<String, dynamic>> items, String query, String searchKey) {
  if (query.isEmpty) {
    return items; // Return original list if query is empty
  }

  final fuse = Fuzzy<Map<String, dynamic>>(items, options: FuzzyOptions(
    keys: [
      WeightedKey(
        name: searchKey,
        getter: (item) => item[searchKey] ?? '',
        weight: 1.0,
      )
    ],
    threshold: 1, // You can adjust this threshold
  ));

  final results = fuse.search(query);

  results.sort((a, b) {
    return (a.score).compareTo(b.score);
  });

  return results.map((result) => result.item).toList();
}

List<Map<String, dynamic>> sortKebabs(
    List<Map<String, dynamic>> kebabs, String orderByField, bool orderDirection, Position userPosition) {

  // Calculate distance for each kebab if orderByField is 'distance'
  if (orderByField == 'distance') {
    for (var kebab in kebabs) {
      double distanceInMeters = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        kebab['lat'],
        kebab['lng'],
      );
      kebab['distance'] = distanceInMeters / 1000;
    }
  }

  // Sort kebabs based on orderByField and orderDirection
  kebabs.sort((a, b) {
    if (orderByField == 'distance') {
      // Special handling for distance sorting
      return orderDirection
          ? b['distance'].compareTo(a['distance'])
          : a['distance'].compareTo(b['distance']);
    } else {
      // Generic sorting for other fields
      return orderDirection
          ? b[orderByField].compareTo(a[orderByField])
          : a[orderByField].compareTo(b[orderByField]);
    }
  });

  return kebabs;
}