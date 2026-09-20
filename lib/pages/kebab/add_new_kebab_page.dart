import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/map/location_picker_modal.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/reviews/thankyou_page.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:kebabbo_flutter/utils/maps_resolver.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum OpeningPreset { none, continuato, notturno, pranzoCena, personalizzato }

class AddNewKebabPage extends StatefulWidget {
  const AddNewKebabPage({super.key});

  @override
  State<AddNewKebabPage> createState() => _AddNewKebabPageState();
}

class _AddNewKebabPageState extends State<AddNewKebabPage> {
  final _formKey = GlobalKey<FormState>();

  // --- Campi Anagrafica ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mapsUrlController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  String _tag = 'kebab';
  bool _glutenFree = false;

  // --- Posizione & Coordinate ---
  double? _selectedLat;
  double? _selectedLng;
  String? _addressText;
  String? _cityName;
  String? _mapUrl;
  String? _mapLinkUrl;
  bool _isResolvingUrl = false;

  // --- Orari di Apertura ---
  OpeningPreset _selectedPreset = OpeningPreset.none;
  final Map<String, String> _customOrari = {
    'lunedì': '11:00-23:00',
    'martedì': '11:00-23:00',
    'mercoledì': '11:00-23:00',
    'giovedì': '11:00-23:00',
    'venerdì': '11:00-23:00',
    'sabato': '11:00-23:00',
    'domenica': '11:00-23:00',
  };

  // --- Foto Copertina ---
  Uint8List? _selectedImageBytes;
  bool _isCompressingImage = false;

  // --- Valutazione Iniziale (Pilastri 1..5) ---
  double _quality = 3.0;
  double _price = 3.0;
  double _dimension = 3.0;
  double _menu = 3.0;
  double _fun = 3.0;

  // --- Ingredienti (1..10) ---
  double _meat = 5.0;
  double _yogurt = 5.0;
  double _spicy = 5.0;
  double _onion = 5.0;
  double _vegetables = 5.0;

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mapsUrlController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  // Risolve il link Google Maps incollato dall'utente
  Future<void> _resolvePastedMapsUrl() async {
    final text = _mapsUrlController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isResolvingUrl = true);
    FocusScope.of(context).unfocus();

    try {
      final details = await MapsResolver.resolveGoogleMapsUrl(text);
      if (details != null && mounted) {
        setState(() {
          _selectedLat = details.lat;
          _selectedLng = details.lng;
          _addressText = details.address;
          _cityName = details.city;
          _mapUrl = text;
          _mapLinkUrl = MapsResolver.buildGoogleMapsUrl(details.lat, details.lng);
          if (details.placeName != null && details.placeName!.trim().isNotEmpty) {
            _nameController.text = details.placeName!.trim();
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              details.placeName != null && details.placeName!.trim().isNotEmpty
                  ? 'Coordinate e nome rilevati dal link Maps! 📍'
                  : 'Coordinate rilevate con successo dal link Maps! 📍',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Impossibile estrarre le coordinate dal link. Usa "Scegli sulla Mappa".',
            ),
            backgroundColor: red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isResolvingUrl = false);
      }
    }
  }

  // Apre il Map Picker interattivo
  Future<void> _openLocationPicker() async {
    final initialPos = (_selectedLat != null && _selectedLng != null)
        ? LatLng(_selectedLat!, _selectedLng!)
        : null;

    final LocationDetails? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocationPickerModal(initialPosition: initialPos),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedLat = result.lat;
        _selectedLng = result.lng;
        _addressText = result.address;
        _cityName = result.city;
        _mapLinkUrl = result.googleMapsUrl;
        _mapUrl = _mapsUrlController.text.trim().isNotEmpty
            ? _mapsUrlController.text.trim()
            : result.googleMapsUrl;
        if (result.placeName != null && result.placeName!.trim().isNotEmpty) {
          _nameController.text = result.placeName!.trim();
        }
      });
    }
  }

  // Selezione Foto
  Future<void> _pickCoverPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final rawBytes = result.files.single.bytes;
      if (rawBytes != null) {
        setState(() => _isCompressingImage = true);
        final compressed = await ImageUtils.compressImage(
          rawBytes,
          450 * 1024,
          1280,
          1280,
        );
        if (mounted) {
          setState(() {
            _selectedImageBytes = compressed ?? rawBytes;
            _isCompressingImage = false;
          });
        }
      }
    }
  }

  // Costruisce la mappa JSON per orari_apertura
  Map<String, String>? _buildOrariMap() {
    switch (_selectedPreset) {
      case OpeningPreset.none:
        return null;
      case OpeningPreset.continuato:
        return {
          'lunedì': '11:00-23:00',
          'martedì': '11:00-23:00',
          'mercoledì': '11:00-23:00',
          'giovedì': '11:00-23:00',
          'venerdì': '11:00-23:00',
          'sabato': '11:00-23:00',
          'domenica': '11:00-23:00',
        };
      case OpeningPreset.notturno:
        return {
          'lunedì': '11:00-02:00',
          'martedì': '11:00-02:00',
          'mercoledì': '11:00-02:00',
          'giovedì': '11:00-02:00',
          'venerdì': '11:00-03:00',
          'sabato': '11:00-03:00',
          'domenica': '11:00-02:00',
        };
      case OpeningPreset.pranzoCena:
        return {
          'lunedì': '11:30-15:00, 18:30-23:30',
          'martedì': '11:30-15:00, 18:30-23:30',
          'mercoledì': '11:30-15:00, 18:30-23:30',
          'giovedì': '11:30-15:00, 18:30-23:30',
          'venerdì': '11:30-15:00, 18:30-23:30',
          'sabato': '11:30-15:00, 18:30-23:30',
          'domenica': '11:30-15:00, 18:30-23:30',
        };
      case OpeningPreset.personalizzato:
        return _customOrari;
    }
  }

  // Invio e Salvataggio Completo
  Future<void> _submitKebab() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedLat == null || _selectedLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona la posizione sulla mappa prima di continuare! 📍'),
          backgroundColor: red,
        ),
      );
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).user_not_authenticated),
          backgroundColor: red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final double calculatedRating =
          (_quality + _price + _dimension + _menu + _fun) / 5.0;
      final orariMap = _buildOrariMap();
      final orariJson = orariMap != null ? jsonEncode(orariMap) : null;
      final finalMapUrl = _mapUrl ?? MapsResolver.buildGoogleMapsUrl(_selectedLat!, _selectedLng!);
      final finalMapLink = _mapLinkUrl ?? finalMapUrl;

      // 1. Inserisci il nuovo locale in 'kebab'
      final kebabResponse = await supabase
          .from('kebab')
          .insert({
            'name': _nameController.text.trim(),
            'description': _reviewController.text.trim(),
            'tag': _tag,
            'gluten_free': _glutenFree,
            'quality': _quality,
            'price': _price,
            'dimension': _dimension,
            'fun': _fun,
            'menu': _menu,
            'meat': _meat.round(),
            'yogurt': _yogurt.round(),
            'spicy': _spicy.round(),
            'onion': _onion.round(),
            'vegetables': _vegetables.round(),
            'rating': calculatedRating,
            'lat': _selectedLat,
            'lng': _selectedLng,
            'map': finalMapUrl,
            'mapLink': finalMapLink,
            'orari_apertura': orariJson,
            'approved': true,
            'is_staff': false,
            'user_reviewed': true,
            'has_card': false,
            'added_by': user.id,
          })
          .select()
          .single();

      final newKebabId = kebabResponse['id'].toString();

      // 2. Inserisci la prima recensione in 'reviews'
      await supabase.from('reviews').insert({
        'kebabber_id': newKebabId,
        'user_id': user.id,
        'description': _reviewController.text.trim(),
        'quality': _quality,
        'price': _price,
        'quantity': _dimension,
        'fun': _fun,
        'menu': _menu,
        'meat': _meat.round(),
        'yogurt': _yogurt.round(),
        'spicy': _spicy.round(),
        'onion': _onion.round(),
        'vegetables': _vegetables.round(),
        'created_at': DateTime.now().toIso8601String(),
      });

      // 3. Carica foto opzionale e crea il primo post correlato al kebab
      if (_selectedImageBytes != null) {
        try {
          final filePath = '${user.id}-${DateTime.now().millisecondsSinceEpoch}.png';
          await supabase.storage.from('posts').uploadBinary(
                filePath,
                _selectedImageBytes!,
                fileOptions: const FileOptions(upsert: true),
              );
          final imageUrl = supabase.storage.from('posts').getPublicUrl(filePath);

          await supabase.from('posts').insert({
            'text': _reviewController.text.trim(),
            'user_id': user.id,
            'created_at': DateTime.now().toIso8601String(),
            'like': [],
            'comments_number': 0,
            'image_url': imageUrl,
            'kebab_tag_id': int.tryParse(newKebabId) ?? newKebabId,
            'kebab_tag_name': _nameController.text.trim(),
          });
        } catch (e) {
          debugPrint('Avviso caricamento foto opzionale: $e');
        }
      }

      // 4. Calcola medaglie recensioni
      bool newMedal = false;
      try {
        final reviewCountRes = await supabase
            .from('reviews')
            .select('id')
            .eq('user_id', user.id)
            .count(CountOption.exact);
        final int reviewCount = reviewCountRes.count;

        final profileRes = await supabase
            .from('profiles')
            .select('medals')
            .eq('id', user.id)
            .maybeSingle();

        final List<int> medals = profileRes?['medals'] != null
            ? List<int>.from(profileRes!['medals'])
            : [];

        if (reviewCount >= 1 && !medals.contains(0)) {
          medals.add(0);
          newMedal = true;
        }
        if (reviewCount >= 5 && !medals.contains(1)) {
          medals.add(1);
          newMedal = true;
        }
        if (reviewCount >= 10 && !medals.contains(2)) {
          medals.add(2);
          newMedal = true;
        }
        if (reviewCount >= 20 && !medals.contains(3)) {
          medals.add(3);
          newMedal = true;
        }
        if (reviewCount >= 30 && !medals.contains(4)) {
          medals.add(4);
          newMedal = true;
        }

        if (newMedal) {
          await supabase
              .from('profiles')
              .update({'medals': medals}).eq('id', user.id);
        }
      } catch (err) {
        debugPrint('Errore assegnazione medaglie: $err');
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ThankYouPage(newMedalEarned: newMedal),
          ),
        );
      }
    } catch (e) {
      debugPrint('Errore inserimento nuovo kebab: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante il salvataggio: $e'),
            backgroundColor: red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Aggiungi un Kebabbaro',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          children: [
            // 1. SEZIONE: Posizione sulla Mappa (Principale)
            _buildSectionCard(
              title: '1. Posizione sulla Mappa 📍',
              icon: Icons.place_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tocca per posizionare il pin o cercare il locale. Coordinate, indirizzo e nome verranno estratti automaticamente!',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 14),

                  // Bottone Principale Mappa
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.map_rounded),
                      label: Text(
                        _selectedLat != null
                            ? 'Modifica Posizione sulla Mappa'
                            : 'Scegli sulla Mappa (Consigliato)',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      onPressed: _openLocationPicker,
                    ),
                  ),

                  // Card Anteprima Posizione Acquisita
                  if (_selectedLat != null && _selectedLng != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF81C784)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 24),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _addressText ?? (_cityName != null ? 'Città: $_cityName' : 'Posizione selezionata'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Lat: ${_selectedLat!.toStringAsFixed(5)}, Lng: ${_selectedLng!.toStringAsFixed(5)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Metodo Secondario: Incolla Link Google Maps (Accordion compatto)
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: const EdgeInsets.only(top: 8, bottom: 4),
                      title: const Text(
                        'Hai già un link di Google Maps? Incollalo qui',
                        style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _mapsUrlController,
                                decoration: InputDecoration(
                                  labelText: 'Link Google Maps',
                                  hintText: 'https://maps.app.goo.gl/...',
                                  prefixIcon: const Icon(Icons.link, color: red),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black87,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _isResolvingUrl ? null : _resolvePastedMapsUrl,
                                child: _isResolvingUrl
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Estrai'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 2. SEZIONE: Dati Principali (Nome e Categoria)
            _buildSectionCard(
              title: '2. Nome e Categoria 🌯',
              icon: Icons.storefront_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome del Kebabbaro *',
                      hintText: 'Es. Bella Istanbul 3',
                      prefixIcon: const Icon(Icons.badge_outlined, color: red),
                      helperText: _nameController.text.isNotEmpty
                          ? 'Compilato automaticamente dalla mappa (modificalo pure)'
                          : null,
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Inserisci il nome del locale';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Tipo Locale (Kebab o Paninoteca)
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectablePill(
                          label: 'Kebab 🌯',
                          isSelected: _tag == 'kebab',
                          onTap: () => setState(() => _tag = 'kebab'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSelectablePill(
                          label: 'Paninoteca 🥪',
                          isSelected: _tag == 'paninoteca',
                          onTap: () => setState(() => _tag = 'paninoteca'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Switch Senza Glutine
                  Container(
                    decoration: BoxDecoration(
                      color: _glutenFree ? const Color(0xFFFEF7E0) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _glutenFree ? const Color(0xFFFFB300) : Colors.grey[300]!,
                      ),
                    ),
                    child: SwitchListTile(
                      activeThumbColor: const Color(0xFFB06000),
                      title: const Text(
                        'Opzione Senza Glutine',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: const Text(
                        'Dispone di piadina o opzioni certificate gluten-free',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: _glutenFree,
                      onChanged: (val) => setState(() => _glutenFree = val),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 3. SEZIONE: Orari di Apertura
            _buildSectionCard(
              title: '3. Orari di Apertura ⏰',
              icon: Icons.access_time_filled_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Puoi lasciarli non specificati come standard, oppure scegliere un template o impostarli personalizzati:',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildPresetChip(
                        label: 'Non specificati (Standard)',
                        preset: OpeningPreset.none,
                      ),
                      _buildPresetChip(
                        label: 'Continuato (11-23) 🌯',
                        preset: OpeningPreset.continuato,
                      ),
                      _buildPresetChip(
                        label: 'Notturno (11-02) 🌙',
                        preset: OpeningPreset.notturno,
                      ),
                      _buildPresetChip(
                        label: 'Pranzo e Cena 🍽️',
                        preset: OpeningPreset.pranzoCena,
                      ),
                      _buildPresetChip(
                        label: 'Personalizzati ⚙️',
                        preset: OpeningPreset.personalizzato,
                      ),
                    ],
                  ),
                  if (_selectedPreset == OpeningPreset.none) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Nessun orario verrà salvato. La scheda mostrerà gli orari come "non disponibili".',
                      style: TextStyle(fontSize: 11, color: Colors.black45, fontStyle: FontStyle.italic),
                    ),
                  ],
                  if (_selectedPreset == OpeningPreset.personalizzato)
                    _buildCustomOrariEditor(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 4. SEZIONE: Foto di Copertina
            _buildSectionCard(
              title: '4. Foto del Locale (Opzionale)',
              icon: Icons.camera_alt_rounded,
              child: Column(
                children: [
                  if (_selectedImageBytes != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _selectedImageBytes!,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 16,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white, size: 16),
                              onPressed: () => setState(() => _selectedImageBytes = null),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    InkWell(
                      onTap: _pickCoverPhoto,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                        ),
                        child: _isCompressingImage
                            ? const Center(child: CircularProgressIndicator(color: red))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo_outlined, size: 36, color: Colors.grey[600]),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Carica una foto dello spiedo o del locale',
                                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 5. SEZIONE: La Tua Prima Recensione
            _buildSectionCard(
              title: '5. La Tua Recensione Iniziale',
              icon: Icons.rate_review_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Descrizione / Recensione *',
                      hintText: 'Racconta com\'è questo kebab: pane, carne, sapori...',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Scrivi un breve commento per presentare il kebabbaro';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'Valutazione Generale (1 a 5)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildSliderRow('Qualità', _quality, (v) => setState(() => _quality = v)),
                  _buildSliderRow('Prezzo', _price, (v) => setState(() => _price = v)),
                  _buildSliderRow('Quantità', _dimension, (v) => setState(() => _dimension = v)),
                  _buildSliderRow('Menù', _menu, (v) => setState(() => _menu = v)),
                  _buildSliderRow('Simpatia', _fun, (v) => setState(() => _fun = v)),

                  const SizedBox(height: 18),
                  const Text(
                    'Bilanciamento Ingredienti (1 a 10)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildSliderRow('Carne', _meat, (v) => setState(() => _meat = v), max: 10, isInteger: true),
                  _buildSliderRow('Yogurt', _yogurt, (v) => setState(() => _yogurt = v), max: 10, isInteger: true),
                  _buildSliderRow('Piccante', _spicy, (v) => setState(() => _spicy = v), max: 10, isInteger: true),
                  _buildSliderRow('Cipolla', _onion, (v) => setState(() => _onion = v), max: 10, isInteger: true),
                  _buildSliderRow('Verdure', _vegetables, (v) => setState(() => _vegetables = v), max: 10, isInteger: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bottone Invia Kebabbaro
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: _isSubmitting
                    ? const SizedBox.shrink()
                    : const Icon(Icons.rocket_launch_rounded),
                label: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Aggiungi Kebabbaro a Kebabbo',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                onPressed: _isSubmitting ? null : _submitKebab,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomOrariEditor() {
    const days = [
      'lunedì',
      'martedì',
      'mercoledì',
      'giovedì',
      'venerdì',
      'sabato',
      'domenica'
    ];

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Imposta gli orari per ciascun giorno (es. 11:00-23:00 oppure "chiuso"):',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          ...days.map((day) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 85,
                    child: Text(
                      '${day[0].toUpperCase()}${day.substring(1)}:',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: TextFormField(
                        initialValue: _customOrari[day] ?? '11:00-23:00',
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (val) => _customOrari[day] = val.trim(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: red, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildSelectablePill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? red : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? red : Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPresetChip({
    required String label,
    required OpeningPreset preset,
  }) {
    final isSelected = _selectedPreset == preset;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFFFFCDD2),
      labelStyle: TextStyle(
        color: isSelected ? red : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      onSelected: (_) => setState(() => _selectedPreset = preset),
    );
  }

  Widget _buildSliderRow(
    String label,
    double value,
    ValueChanged<double> onChanged, {
    double min = 1.0,
    double max = 5.0,
    bool isInteger = false,
  }) {
    final int divisions = isInteger
        ? (max - min).toInt()
        : (((max - min) * 2).toInt());

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: red,
              inactiveTrackColor: Colors.grey[200],
              thumbColor: red,
              overlayColor: red.withValues(alpha: 0.15),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions > 0 ? divisions : null,
              onChanged: (val) {
                onChanged(isInteger ? val.roundToDouble() : val);
              },
            ),
          ),
        ),
        SizedBox(
          width: 32,
          child: Text(
            isInteger ? value.toInt().toString() : value.toStringAsFixed(1),
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
