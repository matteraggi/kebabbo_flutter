import 'package:flutter/material.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

class FilterSearch extends StatefulWidget {
  final bool showOnlyOpen;
  final ValueChanged<bool> onToggleShowOnlyOpen;

  final bool showOnlyKebab;
  final VoidCallback onToggleShowOnlyKebab;

  final String orderByField;
  final bool orderDirection;
  final ValueChanged<String> onChangeOrderByField;
  final ValueChanged<bool> onChangeOrderByDirection;

  final bool useDistanceFilter;
  final double maxDistanceKm;
  final ValueChanged<bool> onToggleUseDistanceFilter;
  final ValueChanged<double> onChangeMaxDistanceKm;

  const FilterSearch({
    super.key,
    required this.showOnlyOpen,
    required this.onToggleShowOnlyOpen,
    required this.showOnlyKebab,
    required this.onToggleShowOnlyKebab,
    required this.orderByField,
    required this.orderDirection,
    required this.onChangeOrderByField,
    required this.onChangeOrderByDirection,
    required this.useDistanceFilter,
    required this.maxDistanceKm,
    required this.onToggleUseDistanceFilter,
    required this.onChangeMaxDistanceKm,
  });

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  late bool _localShowOnlyOpen;
  late bool _localShowOnlyKebab;
  late String _localOrderByField;
  late bool _localOrderDirection;

  late bool _localUseDistanceFilter;
  late double _localMaxDistanceKm;

  @override
  void initState() {
    super.initState();
    _localShowOnlyOpen = widget.showOnlyOpen;
    _localShowOnlyKebab = widget.showOnlyKebab;
    _localOrderByField = widget.orderByField;
    _localOrderDirection = widget.orderDirection;
    _localUseDistanceFilter = widget.useDistanceFilter;
    _localMaxDistanceKm = widget.maxDistanceKm;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65,
      child: Column(
        children: [
          // --- Handle per la sheet ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const Text(
            "Filtri avanzati",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const Divider(height: 24),

          // --- 1. Aperti ora ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _localShowOnlyOpen = !_localShowOnlyOpen;
                });
                widget.onToggleShowOnlyOpen(_localShowOnlyOpen);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                decoration: BoxDecoration(
                  color: _localShowOnlyOpen ? red : Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: _localShowOnlyOpen ? red : Colors.grey[400]!,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _localShowOnlyOpen ? Icons.check : Icons.access_time,
                      color: _localShowOnlyOpen ? Colors.white : Colors.black87,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Aperti ora",
                      style: TextStyle(
                        color:
                            _localShowOnlyOpen ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- 2. Kebab / Panini selector ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!_localShowOnlyKebab) {
                          setState(() {
                            _localShowOnlyKebab = true;
                          });
                          widget.onToggleShowOnlyKebab();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _localShowOnlyKebab ? red : Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.kebab_dining,
                                  color: _localShowOnlyKebab
                                      ? Colors.white
                                      : Colors.black54),
                              const SizedBox(width: 6),
                              Text(
                                "Kebab",
                                style: TextStyle(
                                  color: _localShowOnlyKebab
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_localShowOnlyKebab) {
                          setState(() {
                            _localShowOnlyKebab = false;
                          });
                          widget.onToggleShowOnlyKebab();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color:
                              !_localShowOnlyKebab ? red : Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.fastfood,
                                  color: !_localShowOnlyKebab
                                      ? Colors.white
                                      : Colors.black54),
                              const SizedBox(width: 6),
                              Text(
                                "Panini",
                                style: TextStyle(
                                  color: !_localShowOnlyKebab
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // --- 3. Ordinamento ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ordina per",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: red, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _localOrderByField,
                            borderRadius: BorderRadius.circular(20),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _localOrderByField = value;
                                });
                                widget.onChangeOrderByField(value);
                              }
                            },
                            style: const TextStyle(
                              color: red,
                              fontWeight: FontWeight.bold,
                            ),
                            items: const [
                              'stelle',
                              'qualità',
                              'prezzo',
                              'dimensione',
                              'menu',
                              'nome',
                              'distanza'
                            ].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.toUpperCase()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _localOrderDirection = !_localOrderDirection;
                        });
                        widget.onChangeOrderByDirection(_localOrderDirection);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          _localOrderDirection
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

// --- 4. Distanza massima ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filtra per distanza",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: _localUseDistanceFilter,
                  activeThumbColor: red,
                  onChanged: (enabled) {
                    setState(() {
                      _localUseDistanceFilter = enabled;
                    });
                    widget.onToggleUseDistanceFilter(enabled);

                    // se lo riaccende, ripassa la distanza corrente
                    if (enabled) {
                      widget.onChangeMaxDistanceKm(_localMaxDistanceKm);
                    } else {
                      // se lo spegne, TopKebabPage lo porta a infinity
                      // quindi qui non serve altro
                    }
                  },
                ),
              ],
            ),
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _localUseDistanceFilter
                ? Column(
                    key: const ValueKey("slider"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "0 km",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  "${_localMaxDistanceKm.toStringAsFixed(1)} km",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: red,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  "100 km",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: red,
                                inactiveTrackColor: Colors.red.withOpacity(0.2),
                                thumbColor: red,
                                overlayColor: red.withOpacity(0.1),
                                trackHeight: 6,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 10),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 20),
                                valueIndicatorShape:
                                    const PaddleSliderValueIndicatorShape(),
                                valueIndicatorTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max: 100,
                                divisions: 50,
                                label:
                                    "${_localMaxDistanceKm.toStringAsFixed(1)} km",
                                value: _localMaxDistanceKm,
                                onChanged: (value) {
                                  setState(() {
                                    _localMaxDistanceKm = value;
                                  });
                                  widget.onChangeMaxDistanceKm(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    key: ValueKey("empty"),
                    height: 0,
                  ),
          ),

          const Spacer(),

          // --- Pulsante Chiudi ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Chiudi",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
