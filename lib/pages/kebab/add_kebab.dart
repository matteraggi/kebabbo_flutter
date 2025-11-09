import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/main.dart' as main;

class AddKebab extends StatefulWidget {
  const AddKebab({super.key});

  @override
  State<AddKebab> createState() => _AddKebabState();
}

class _AddKebabState extends State<AddKebab> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  // Controller per i campi di testo rimasti
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Valori per gli slider da 1 a 5
  double _quality = 3.0;
  double _price = 3.0;
  double _dimension = 3.0;
  double _fun = 3.0;
  double _menu = 3.0;

  // Valori per gli slider da 1 a 10
  double _meat = 5.0;
  double _yogurt = 5.0;
  double _spicy = 5.0;
  double _onion = 5.0;
  double _vegetables = 5.0;

  // Valore per il tag switch
  String _tag = 'kebab'; // 'kebab' o 'sandwich'

  // Valore per lo switch glutine
  bool _glutenFree = false;

  bool _loading = false;

  Future<void> _addKebab() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await supabase.from('kebab').insert({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        // Valori dagli slider 1-5
        'quality': _quality,
        'price': _price,
        'dimension': _dimension,
        'fun': _fun,
        'menu': _menu,
        // Valori dagli slider 1-10
        'yogurt': _yogurt,
        'spicy': _spicy,
        'meat': _meat,
        'onion': _onion,
        'vegetables': _vegetables,
        // Valore dal tag switch
        'tag': _tag,
        // Valore dallo switch glutine
        'gluten_free': _glutenFree,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kebab aggiunto con successo!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante l\'aggiunta del kebab: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  // Helper per i campi di testo (con sfondo bianco)
  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white, // Sfondo bianco
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Campo obbligatorio' : null,
      ),
    );
  }

  // Helper per gli switch on/off
  Widget _buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: main.red,
      activeTrackColor: main.red.withOpacity(0.5),
    );
  }

  // Helper per gli slider
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
              Text(value.toStringAsFixed(0),
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
            label: value.toStringAsFixed(0),
            activeColor: main.red,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi un Kebab'),
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
                    _buildTextField(label: 'Nome', controller: _nameController),
                    _buildTextField(
                        label: 'Descrizione',
                        controller: _descriptionController),
                    const SizedBox(height: 16),

                    // --- Switch per Tag (Kebab/Sandwich) ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _tag = 'kebab'),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _tag == 'kebab'
                                      ? main.red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _tag = 'sandwich'),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _tag == 'sandwich'
                                      ? main.red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.fastfood,
                                        color: _tag == 'sandwich'
                                            ? Colors.white
                                            : Colors.black54),
                                    const SizedBox(width: 8),
                                    Text('Sandwich',
                                        style: TextStyle(
                                            color: _tag == 'sandwich'
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- Slider da 1 a 5 ---
                    _buildSlider('Qualità', _quality, 1, 5, 4,
                        (val) => setState(() => _quality = val)),
                    _buildSlider('Prezzo', _price, 1, 5, 4,
                        (val) => setState(() => _price = val)),
                    _buildSlider('Dimensione', _dimension, 1, 5, 4,
                        (val) => setState(() => _dimension = val)),
                    _buildSlider('Fun', _fun, 1, 5, 4,
                        (val) => setState(() => _fun = val)),
                    _buildSlider('Menu', _menu, 1, 5, 4,
                        (val) => setState(() => _menu = val)),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // --- Slider da 1 a 10 ---
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

                    // --- Switch Senza Glutine ---
                    _buildSwitch('Senza Glutine', _glutenFree,
                        (value) => setState(() => _glutenFree = value)),

                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Aggiungi'),
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
                      onPressed: _addKebab,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}