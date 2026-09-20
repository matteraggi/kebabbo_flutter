import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/reviews/thankyou_page.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WriteReviewPage extends StatefulWidget {
  final int? preselectedKebabId;
  final String? preselectedKebabName;

  const WriteReviewPage({
    super.key,
    this.preselectedKebabId,
    this.preselectedKebabName,
  });

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _allKebabs = [];
  List<Map<String, dynamic>> _filteredKebabs = [];
  Map<String, dynamic>? _selectedKebab;
  bool _isLoadingKebabs = true;

  // Valutazione 5 pilastri (1..5)
  double _quality = 3.0;
  double _price = 3.0;
  double _dimension = 3.0;
  double _menu = 3.0;
  double _fun = 3.0;

  // Bilanciamento 5 ingredienti (1..10)
  double _meat = 5.0;
  double _yogurt = 5.0;
  double _spicy = 5.0;
  double _onion = 5.0;
  double _vegetables = 5.0;

  // Foto opzionale
  Uint8List? _selectedImageBytes;
  bool _isCompressingImage = false;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchKebabs();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchKebabs() async {
    setState(() => _isLoadingKebabs = true);
    try {
      final response = await supabase
          .from('kebab')
          .select('id, name, tag')
          .order('name', ascending: true);

      final list = List<Map<String, dynamic>>.from(response as List);

      if (mounted) {
        setState(() {
          _allKebabs = list;
          _filteredKebabs = list;
          _isLoadingKebabs = false;

          // Se è stato passato un kebab pre-selezionato
          if (widget.preselectedKebabId != null) {
            final match = list.firstWhere(
              (k) => k['id'] == widget.preselectedKebabId,
              orElse: () => {
                'id': widget.preselectedKebabId,
                'name': widget.preselectedKebabName ?? 'Kebab',
              },
            );
            _selectedKebab = match;
            _searchController.text = match['name'] ?? '';
          }
        });
      }
    } catch (e) {
      debugPrint('Errore caricamento lista kebab: $e');
      if (mounted) {
        setState(() => _isLoadingKebabs = false);
      }
    }
  }

  void _filterKebabs(String query) {
    if (query.trim().isEmpty) {
      setState(() => _filteredKebabs = _allKebabs);
      return;
    }
    final q = query.toLowerCase();
    setState(() {
      _filteredKebabs = _allKebabs
          .where((k) => (k['name'] ?? '').toString().toLowerCase().contains(q))
          .toList();
    });
  }

  Future<void> _pickPhoto() async {
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

  Future<void> _submitReview() async {
    if (_selectedKebab == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona il kebabbaro da recensire! 🌯'),
          backgroundColor: red,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

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
      final kebabId = _selectedKebab!['id'].toString();

      // 1. Inserisci la recensione in 'reviews'
      await supabase.from('reviews').insert({
        'kebabber_id': kebabId,
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

      // 2. Se c'è una foto, crea anche un post correlato
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
            'kebab_tag_id': int.tryParse(kebabId) ?? kebabId,
            'kebab_tag_name': _selectedKebab!['name'] ?? '',
          });
        } catch (photoErr) {
          debugPrint('Avviso upload foto recensione: $photoErr');
        }
      }

      // 3. Calcolo e sblocco medaglie
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
        debugPrint('Errore aggiornamento medaglie: $err');
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
      debugPrint('Errore invio recensione: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore invio recensione: $e'),
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
          'Scrivi una Recensione',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: _isLoadingKebabs
          ? const Center(child: CircularProgressIndicator(color: red))
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                children: [
                  // 1. Selezione del Kebabbaro
                  _buildSectionCard(
                    title: 'Scegli il Kebabbaro',
                    icon: Icons.storefront_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_selectedKebab != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFFFB74D)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Color(0xFFE65100), size: 24),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _selectedKebab!['name'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFFBF360C),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedKebab = null;
                                      _searchController.clear();
                                      _filteredKebabs = _allKebabs;
                                    });
                                  },
                                  child: const Text('Cambia'),
                                ),
                              ],
                            ),
                          )
                        else ...[
                          TextField(
                            controller: _searchController,
                            onChanged: _filterKebabs,
                            decoration: InputDecoration(
                              labelText: 'Cerca tra i locali di Kebabbo',
                              hintText: 'Es. Istanbul, Agra, King...',
                              prefixIcon: const Icon(Icons.search, color: red),
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            constraints: const BoxConstraints(maxHeight: 180),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: _filteredKebabs.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Nessun locale trovato. Se è nuovo, usa "Aggiungi un Kebabbaro"!',
                                        style: TextStyle(color: Colors.grey, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _filteredKebabs.length,
                                    separatorBuilder: (_, __) => const Divider(height: 1),
                                    itemBuilder: (context, index) {
                                      final k = _filteredKebabs[index];
                                      return ListTile(
                                        dense: true,
                                        leading: Icon(
                                          k['tag'] == 'kebab'
                                              ? Icons.lunch_dining
                                              : Icons.fastfood_outlined,
                                          color: red,
                                        ),
                                        title: Text(
                                          k['name'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedKebab = k;
                                            _searchController.text = k['name'] ?? '';
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. Votazione Pilastri
                  _buildSectionCard(
                    title: 'Valutazione Generale (1 a 5)',
                    icon: Icons.star_rounded,
                    child: Column(
                      children: [
                        _buildSliderRow('Qualità', _quality, (v) => setState(() => _quality = v)),
                        _buildSliderRow('Prezzo', _price, (v) => setState(() => _price = v)),
                        _buildSliderRow('Quantità', _dimension, (v) => setState(() => _dimension = v)),
                        _buildSliderRow('Menù', _menu, (v) => setState(() => _menu = v)),
                        _buildSliderRow('Simpatia', _fun, (v) => setState(() => _fun = v)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Bilanciamento Ingredienti
                  _buildSectionCard(
                    title: 'Bilanciamento Ingredienti (1 a 10)',
                    icon: Icons.pie_chart_rounded,
                    child: Column(
                      children: [
                        _buildSliderRow('Carne', _meat, (v) => setState(() => _meat = v), max: 10, isInteger: true),
                        _buildSliderRow('Yogurt', _yogurt, (v) => setState(() => _yogurt = v), max: 10, isInteger: true),
                        _buildSliderRow('Piccante', _spicy, (v) => setState(() => _spicy = v), max: 10, isInteger: true),
                        _buildSliderRow('Cipolla', _onion, (v) => setState(() => _onion = v), max: 10, isInteger: true),
                        _buildSliderRow('Verdure', _vegetables, (v) => setState(() => _vegetables = v), max: 10, isInteger: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 4. Testo Recensione & Foto
                  _buildSectionCard(
                    title: 'La Tua Esperienza',
                    icon: Icons.rate_review_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _reviewController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Commento / Recensione *',
                            hintText: 'Cosa ti è piaciuto di più? Consigli qualche salsa o menù?',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Scrivi un breve commento sulla tua esperienza';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Foto Opzionale
                        if (_selectedImageBytes != null)
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  _selectedImageBytes!,
                                  width: double.infinity,
                                  height: 160,
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
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[800],
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: _isCompressingImage
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: red),
                                  )
                                : const Icon(Icons.add_a_photo_outlined),
                            label: const Text('Aggiungi Foto al Piatto (Opzionale)'),
                            onPressed: _pickPhoto,
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottone Invia Recensione
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
                          : const Icon(Icons.send_rounded),
                      label: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Pubblica Recensione',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                      onPressed: _isSubmitting ? null : _submitReview,
                    ),
                  ),
                ],
              ),
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
