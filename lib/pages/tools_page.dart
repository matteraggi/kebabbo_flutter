import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/ingredient_item.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab_recommandation_page.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

class ToolsPage extends StatefulWidget {
  final Position? currentPosition;

  const ToolsPage({super.key, required this.currentPosition});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> 
 {
  // Store the amounts for each ingredient
  Map<String, int> ingredientAmounts = {
    'meat': 5,
    'onion': 5,
    'spicy': 5,
    'yogurt': 5,
    'vegetables': 5,
  };

  // State variable for the maximum distance
  double maxDistance = 1; // Initially unlimited

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your Kebab'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 650;

          return Center(
            child: isDesktop
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ingredient controls
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (String ingredient
                                    in ingredientAmounts.keys)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: IngredientControl(
                                      ingredientName: ingredient,
                                      amount: ingredientAmounts[ingredient]!,
                                      onAmountChanged: (amount) {
                                        setState(() {
                                          ingredientAmounts[ingredient] =
                                              amount;
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width:
                                  30), // Space between ingredients and sliders
                          // Sliders on the right (for desktop view) with padding to the right
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30), // Right padding
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (String ingredient
                                      in ingredientAmounts.keys)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // Center the name
                                        children: [
                                          Text(
                                            ingredient,
                                            // Centered ingredient name
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                            // Center text
                                          ),
                                          Slider(
                                            value: ingredientAmounts[ingredient]!
                                                .toDouble(),
                                            min: 0,
                                            max: 10,
                                            divisions: 10,
                                            activeColor:
                                                red, // Set slider color to red
                                            onChanged: (value) {
                                              setState(() {
                                                ingredientAmounts[ingredient] =
                                                    value.toInt();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(
                                      height:
                                          20), // Space between ingredients and distance slider
                                  const Text(
                                    'Distanza Massima',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  _buildDistanceSlider(),
                                  const SizedBox(
                                      height:
                                          30), // Space above the button
                                  buildButton(),
                                  // Add the Build button here
                                  const SizedBox(
                                      height:
                                          20), // Space below the button
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ingredient controls
                        for (String ingredient in ingredientAmounts.keys)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            child: IngredientControl(
                              ingredientName: ingredient,
                              amount: ingredientAmounts[ingredient]!,
                              onAmountChanged: (amount) {
                                setState(() {
                                  ingredientAmounts[ingredient] = amount;
                                });
                              },
                            ),
                          ),
                        const SizedBox(
                            height:
                                20), // Space between ingredients and sliders
                        // Sliders at the bottom (for mobile view)
                        for (String ingredient in ingredientAmounts.keys)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // Center the name
                              children: [
                                Text(
                                  ingredient,
                                  // Centered ingredient name
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center, // Center text
                                ),
                                Slider(
                                  value: ingredientAmounts[ingredient]!
                                      .toDouble(),
                                  min: 0,
                                  max: 10,
                                  divisions: 10,
                                  activeColor:
                                      red, // Set slider color to red
                                  onChanged: (value) {
                                    setState(() {
                                      ingredientAmounts[ingredient] =
                                          value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                            height:
                                20), // Space between ingredients and distance slider
                        const Text(
                          'Distanza Massima',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildDistanceSlider(),
                        const SizedBox(
                            height: 30), // Space above the button
                        Align(
                          alignment: Alignment.center,
                          // Align the button to the right
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: buildButton(),
                            // Add the Build button here
                          ),
                        ),
                        const SizedBox(height: 20), // Space below the button
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  // Widget for the Build button
  Widget buildButton() {
    return ElevatedButton(
      onPressed: () async {
        Map<String, dynamic>? result =
            await buildKebab(ingredientAmounts, 0, maxDistance, widget.currentPosition);
        Map<String, dynamic>? bestKebab;
        int availableKebabs = 0;
        if (result != null) {
          bestKebab = result['kebab'];
          availableKebabs = result['availableKebabs'];
        }
        if (bestKebab != null) {
          // Navigate to the recommendation page with the selected kebab
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KebabRecommendationPage(
                kebab: bestKebab!,
                availableKebabs: availableKebabs,
                ingredients: ingredientAmounts,
                maxDistance: maxDistance,
                currentPosition: widget.currentPosition,
              ),
            ),
          );
        } else {
          // Handle the case where no match is found
          // (e.g., show a SnackBar or an AlertDialog)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Nessun kebab corrispondente trovato nel raggio selezionato')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: red, // Red color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Pill shape
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 50, vertical: 15), // Padding for button size
      ),
      child: const Text(
        'Build!',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

Widget _buildDistanceSlider() {
  return SliderTheme(
    data: SliderTheme.of(context).copyWith(
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    child: Slider(
      value: _mapDistanceToSliderValue(maxDistance),
      min: 0,
      max: 4,
      divisions: 4,
      label: _getDistanceLabel(maxDistance),
      activeColor: Colors.white,
      onChanged: (value) {
        setState(() {
          maxDistance = _mapSliderValueToDistance(value);
        });
      },
    ),
  );
}

  // Helper function to map distance values to slider values
  double _mapDistanceToSliderValue(double distance) {
    if (distance <= 0.2) {
      return 0;
    } else if (distance <= 0.5) {
      return 1;
    } else if (distance <= 1) {
      return 2;
    } else if (distance <= 10) {
      return 3;
    } else {
      return 4;
    }
  }

  // Helper function to map slider values to distance values
  double _mapSliderValueToDistance(double sliderValue) {
    switch (sliderValue.toInt()) {
      case 0:
        return 0.2;
      case 1:
        return 0.5;
      case 2:
        return 1;
      case 3:
        return 10;
      default:
        return double.infinity;
    }
  }

  // Helper function to get the distance label
  String _getDistanceLabel(double distance) {
    if (distance <= 0.2) {
      return ' 200 metri ';
    } else if (distance <= 0.5) {
      return ' 500 metri ';
    } else if (distance <= 1) {
      return ' 1 km ';
    } else if (distance <= 10) {
      return ' 10 km ';
    } else {
      return ' Illimitato ';
    }
  }
 }