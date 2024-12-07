import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class OrderBar extends StatelessWidget {
  final String orderByField;
  final bool orderDirection;
  final Function(String) onChangeOrderByField;
  final Function(bool) onChangeOrderDirection;
  final Function() changeShowOnlyKebab;
  final bool showOnlyKebab;

  const OrderBar({
    super.key,
    required this.orderByField,
    required this.orderDirection,
    required this.onChangeOrderByField,
    required this.onChangeOrderDirection,
    required this.changeShowOnlyKebab,
    required this.showOnlyKebab,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.fastfood,
                    color: showOnlyKebab
                        ? const Color.fromARGB(255, 185, 184, 184)
                        : yellow),
                SizedBox(width: 8),
                Switch(
                  value: showOnlyKebab,
                  onChanged: (bool value) {
                    changeShowOnlyKebab();
                  },
                  activeColor: Colors.white,
                  activeTrackColor: yellow,
                ),
                SizedBox(width: 8),
                Icon(Icons.kebab_dining,
                    color: showOnlyKebab
                        ? yellow
                        : const Color.fromARGB(255, 185, 184, 184)),
              ],
            ),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: red, width: 4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(30),
                      alignment: Alignment.center,
                      enableFeedback: true,
                      value: orderByField,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          onChangeOrderByField(newValue);
                        }
                      },
                      iconSize: 0,
                      icon: const SizedBox(
                        width: 5,
                      ),
                      style: const TextStyle(color: red),
                      items: <String>[
                        'stelle',
                        'qualità',
                        'prezzo',
                        'dimensione',
                        'menu',
                        'nome',
                        'distanza',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(
                            value.toUpperCase(),
                            style: const TextStyle(
                                color: red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    onChangeOrderDirection(!orderDirection);
                  },
                  child: Icon(
                    orderDirection ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
