import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/components/map/location_picker_modal.dart';
import 'package:latlong2/latlong.dart';

// 1x1 transparent PNG bytes
final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

class MockTileProvider extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    return MemoryImage(kTransparentImage);
  }
}

void main() {
  testWidgets('LocationPickerModal renders search bar and confirm button',
      (WidgetTester tester) async {
    const testLocation = LatLng(44.4949, 11.3426);

    await tester.pumpWidget(
      MaterialApp(
        home: LocationPickerModal(
          initialPosition: testLocation,
          autoLocate: false,
          tileProvider: MockTileProvider(),
        ),
      ),
    );

    // Verify AppBar Title
    expect(find.text('Seleziona sulla Mappa'), findsOneWidget);

    // Verify Search Bar hint text
    expect(find.text('Cerca indirizzo o locale...'), findsOneWidget);

    // Verify Confirm Button
    expect(find.text('Conferma Questa Posizione'), findsOneWidget);
  });
}
