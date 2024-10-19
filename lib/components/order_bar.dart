import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class OrderBar extends StatelessWidget {
  final String orderByField;
  final bool orderDirection;
  final Function(String) onChangeOrderByField;
  final Function(bool) onChangeOrderDirection;

  const OrderBar({super.key, 
    required this.orderByField,
    required this.orderDirection,
    required this.onChangeOrderByField,
    required this.onChangeOrderDirection,
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
            const Text(
              "Ordina per:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                        'rating',
                        'quality',
                        'price',
                        'dimension',
                        'menu',
                        'name',
                        'distance',
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
