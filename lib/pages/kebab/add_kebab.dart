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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();
  final TextEditingController _funController = TextEditingController();
  final TextEditingController _menuController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final TextEditingController _meatController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  bool _yogurt = false;
  bool _spicy = false;
  bool _onion = false;
  bool _vegetables = false;
  bool _glutenFree = false;

  bool _loading = false;

  Future<void> _addKebab() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await supabase.from('kebab').insert({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'quality': _qualityController.text.trim(),
        'price': double.tryParse(_priceController.text.trim()) ?? 0.0,
        'dimension': _dimensionController.text.trim(),
        'fun': _funController.text.trim(),
        'menu': _menuController.text.trim(),
        'lat': double.tryParse(_latController.text.trim()),
        'lng': double.tryParse(_lngController.text.trim()),
        'yogurt': _yogurt,
        'spicy': _spicy,
        'meat': _meatController.text.trim(),
        'onion': _onion,
        'tag': _tagController.text.trim(),
        'vegetables': _vegetables,
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
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Campo obbligatorio' : null,
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeThumbColor: main.red,
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
                    _buildTextField(
                        label: 'Qualità', controller: _qualityController),
                    _buildTextField(
                        label: 'Prezzo',
                        controller: _priceController,
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true)),
                    _buildTextField(
                        label: 'Dimensione', controller: _dimensionController),
                    _buildTextField(
                        label: 'Divertimento', controller: _funController),
                    _buildTextField(label: 'Menu', controller: _menuController),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                label: 'Latitudine',
                                controller: _latController,
                                inputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: _buildTextField(
                                label: 'Longitudine',
                                controller: _lngController,
                                inputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true))),
                      ],
                    ),
                    _buildTextField(
                        label: 'Carne', controller: _meatController),
                    _buildTextField(label: 'Tag', controller: _tagController),
                    const SizedBox(height: 12),
                    _buildSwitch('Yogurt', _yogurt,
                        (value) => setState(() => _yogurt = value)),
                    _buildSwitch('Piccante', _spicy,
                        (value) => setState(() => _spicy = value)),
                    _buildSwitch('Cipolla', _onion,
                        (value) => setState(() => _onion = value)),
                    _buildSwitch('Verdure', _vegetables,
                        (value) => setState(() => _vegetables = value)),
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
