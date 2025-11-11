import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/filter_search.dart';
import 'package:kebabbo_flutter/pages/reviews/thankyou_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/main.dart' as main;
// Importa la tua funzione di fuzzy search
import 'package:kebabbo_flutter/utils/utils.dart';

class AddKebab extends StatefulWidget {
  final String? kebabId;
  final String? kebabName;
  const AddKebab({
    super.key,
    this.kebabId,
    this.kebabName,
  });

  @override
  State<AddKebab> createState() => _AddKebabState();
}

class _AddKebabState extends State<AddKebab> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  // Controller per i campi di testo
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewTextController = TextEditingController();

  // Lista di tutti i kebab per l'autocomplete
  List<Map<String, dynamic>> _allKebabs = [];
  // Il kebab selezionato dall'autocomplete
  Map<String, dynamic>? _selectedKebab;

  // Valori per gli slider
  double _quality = 3.0;
  double _price = 3.0;
  double _dimension = 3.0;
  double _fun = 3.0;
  double _menu = 3.0;
  double _meat = 5.0;
  double _yogurt = 5.0;
  double _spicy = 5.0;
  double _onion = 5.0;
  double _vegetables = 5.0;
  String _tag = 'kebab';
  bool _glutenFree = false;
  bool _loading = false;

@override
  void initState() {
    super.initState();
    _fetchAllKebabs();

    // Pre-compila il form se i dati sono stati passati
    if (widget.kebabId != null && widget.kebabName != null) {
      _nameController.text = widget.kebabName!;
      // Imposta il kebab selezionato per la logica di submit
      _selectedKebab = {
        'id': widget.kebabId!, // Assicurati che il tipo sia corretto
        'name': widget.kebabName!,
      };
      
      // Sposta il cursore alla fine
      _nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameController.text.length),
      );
    }
  }

  // Carica tutti i kebab per l'autocomplete
  Future<void> _fetchAllKebabs() async {
    try {
      final response = await supabase.from('kebab').select('id, name');
      if (mounted) {
        setState(() {
          _allKebabs = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore nel caricare i kebab: $e'),
            backgroundColor: red,
          ),
        );
      }
    }
  }

  // Logica di submit principale
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Controlla se l'utente ha selezionato un kebab o ne sta creando uno nuovo
    if (_selectedKebab != null &&
        _selectedKebab!['name'] == _nameController.text) {
      // Caso 1: L'utente ha selezionato un kebab esistente
      setState(() => _loading = true);
      await _addReviewToDatabase(_selectedKebab!['id'].toString());
      setState(() => _loading = false);
    } else {
      // Caso 2: L'utente sta creando un nuovo kebab
      final String? cityName = await _showConfirmationDialog();
      if (cityName != null && cityName.isNotEmpty) {
        setState(() => _loading = true);
        await _createNewKebabAndAddReview(cityName);
        setState(() => _loading = false);
      }
    }
  }

  // Popup di conferma
  Future<String?> _showConfirmationDialog() {
    final cityController = TextEditingController(text: 'Bologna');

    return showDialog<String?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kebab non trovato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Stai per aggiungere "${_nameController.text}" come nuovo kebab. Sei sicuro che non sia già presente?'),
              const SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'Città',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: main.red),
              onPressed: () {
                Navigator.pop(context, cityController.text);
              },
              child: const Text('Sì, crea nuovo'),
            ),
          ],
        );
      },
    );
  }

  // Funzione per creare un NUOVO Kebab E POI aggiungere la recensione
  Future<void> _createNewKebabAndAddReview(String cityName) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Utente non autenticato');
      // Crea il nuovo kebab
      final response = await supabase
          .from('kebab')
          .insert({
            'name': _nameController.text.trim(),
            // Salva la recensione come descrizione
            'description': _reviewTextController.text.trim(),
            'tag': _tag,
            'gluten_free': _glutenFree,
            'user_reviewed': true,
            'is_staff': false,
            'mapLink': cityName,
            'quality': _quality,
            'price': _price,
            'dimension': _dimension,
            'fun': _fun,
            'menu': _menu,
            'meat': _meat,
            'yogurt': _yogurt,
            'spicy': _spicy,
            'onion': _onion,
            'vegetables': _vegetables,
            'added_by': userId, // Questo soddisfa la tua RLS policy
          })
          .select()
          .single();

      final newKebabId = response['id'].toString();

      // Aggiungi la recensione per il nuovo kebab
      await _addReviewToDatabase(newKebabId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: red,
          ),
        );
      }
    }
  }

  // Funzione per aggiungere una RECENSIONE
  Future<void> _addReviewToDatabase(String kebabId) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Utente non autenticato');

      await supabase.from('reviews').insert({
        'kebabber_id': kebabId,
        'user_id': userId,
        'description': _reviewTextController.text.trim(),
        'quality': _quality,
        'price': _price,
        'quantity': _dimension,
        'fun': _fun,
        'menu': _menu,
        'meat': _meat,
        'yogurt': _yogurt,
        'spicy': _spicy,
        'onion': _onion,
        'vegetables': _vegetables,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ThankYouPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante l\'aggiunta della recensione: $e'),
            backgroundColor: red,
          ),
        );
      }
    }
  }
  // --- Widget Builders ---

  // Autocomplete
  Widget _buildNameAutocomplete() {
    final bool isPreFilled = widget.kebabId != null;
    return Autocomplete<Map<String, dynamic>>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        _nameController.text = textEditingValue.text;

        if (textEditingValue.text.isEmpty) {
          if (_selectedKebab != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() => _selectedKebab = null);
            });
          }
          return const Iterable<Map<String, dynamic>>.empty();
        }

        if (_selectedKebab != null &&
            _selectedKebab!['name'] != textEditingValue.text) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => _selectedKebab = null);
          });
        }

        final results = fuzzySearchAndSort(
          _allKebabs,
          textEditingValue.text,
          'name',
          false,
          false,
        );
        return results.take(1);
      },
      displayStringForOption: (option) => option['name'],
      onSelected: (selection) {
        setState(() {
          _selectedKebab = selection;
          _nameController.text = selection['name'];
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        if (isPreFilled && textEditingController.text.isEmpty) {
          textEditingController.text = widget.kebabName!;
        }

        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          enabled: !isPreFilled, // <-- DISABILITA IL CAMPO
          decoration: InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            // Colora di grigio se disabilitato
            fillColor: isPreFilled ? Colors.grey[200] : Colors.white, 
          ),
          validator: (value) =>
              value == null || value.trim().isEmpty ? 'Campo obbligatorio' : null,
          onChanged: (value) {
            _nameController.text = value; 
            if (_selectedKebab != null) {
              setState(() => _selectedKebab = null);
            }
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(option['name']),
                    subtitle: const Text("Kebab già esistente"),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (isOptional) return null; // Non validare se opzionale
            return value == null || value.trim().isEmpty
                ? 'Campo obbligatorio'
                : null;
          }),
    );
  }

  Widget _buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeThumbColor: main.red,
      activeTrackColor: main.red.withValues(alpha: 0.5),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    int divisions,
    void Function(double) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(value.toStringAsFixed(1), // Mostra una cifra decimale
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: main.red)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: value.toStringAsFixed(1), // Mostra una cifra decimale
            activeColor: main.red,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKebabSelected = _selectedKebab != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Recensione'),
        backgroundColor: main.red,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildNameAutocomplete(),
                    const SizedBox(height: 8),

                    _buildTextField(
                      label: 'La tua recensione (opzionale)',
                      controller: _reviewTextController,
                      isOptional: true, // Questo lo rende opzionale
                    ),
                    const SizedBox(height: 16),

                    // Campi visibili solo se si crea un nuovo kebab
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return SizeTransition(
                            sizeFactor: animation, child: child);
                      },
                      child: !isKebabSelected
                          ? Column(
                              children: [
                                // La descrizione è stata spostata
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              setState(() => _tag = 'kebab'),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: _tag == 'kebab'
                                                  ? main.red
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.kebab_dining,
                                                    color: _tag == 'kebab'
                                                        ? Colors.white
                                                        : Colors.black54),
                                                const SizedBox(width: 8),
                                                Text('Kebab',
                                                    style: TextStyle(
                                                        color: _tag == 'kebab'
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              setState(() => _tag = 'sandwich'),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: _tag == 'sandwich'
                                                  ? main.red
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.fastfood,
                                                    color: _tag == 'sandwich'
                                                        ? Colors.white
                                                        : Colors.black54),
                                                const SizedBox(width: 8),
                                                Text('Sandwich',
                                                    style: TextStyle(
                                                        color: _tag ==
                                                                'sandwich'
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 24),

                    // Slider (Sempre visibili)
                    _buildSlider('Qualità', _quality, 1, 5, 8,
                        (val) => setState(() => _quality = val)),
                    _buildSlider('Prezzo', _price, 1, 5, 8,
                        (val) => setState(() => _price = val)),
                    _buildSlider('Dimensione', _dimension, 1, 5, 8,
                        (val) => setState(() => _dimension = val)),
                    _buildSlider('Fun', _fun, 1, 5, 8,
                        (val) => setState(() => _fun = val)),
                    _buildSlider('Menu', _menu, 1, 5, 8,
                        (val) => setState(() => _menu = val)),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildSlider('Carne', _meat, 1, 10, 9,
                        (val) => setState(() => _meat = val)),
                    _buildSlider('Yogurt', _yogurt, 1, 10, 9,
                        (val) => setState(() => _yogurt = val)),
                    _buildSlider('Piccante', _spicy, 1, 10, 9,
                        (val) => setState(() => _spicy = val)),
                    _buildSlider('Cipolla', _onion, 1, 10, 9,
                        (val) => setState(() => _onion = val)),
                    _buildSlider('Verdure', _vegetables, 1, 10, 9,
                        (val) => setState(() => _vegetables = val)),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // --- Switch Senza Glutine (Visibile solo se si crea) ---
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return SizeTransition(
                              sizeFactor: animation, child: child);
                        },
                        child: !isKebabSelected
                            ? _buildSwitch('Senza Glutine', _glutenFree,
                                (value) => setState(() => _glutenFree = value))
                            : const SizedBox.shrink()),
                    const SizedBox(height: 20),

                    // --- Pulsante di Submit ---
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_comment),
                      label: const Text('Invia Recensione'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: main.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
