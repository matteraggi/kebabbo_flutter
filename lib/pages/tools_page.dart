import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/ingredient_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab_recommandation_page.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:kebabbo_flutter/utils/ingredients_logic.dart';

class ToolsPage extends StatefulWidget {
  final Position? currentPosition;
  final List<int> ingredients;
  final Function(List<int>) onIngredientsUpdated; // Callback for updating ingredients

  const ToolsPage({super.key, required this.currentPosition, required this.ingredients, required this.onIngredientsUpdated});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> with TickerProviderStateMixin {
  // Store the amounts for each ingredient
  Map<String, int> ingredientAmounts = {
    'meat': 5,
    'onion': 5,
    'spicy': 5,
    'yogurt': 5,
    'vegetables': 5,
  };
  bool isConverging = false; // Convergence trigger
  bool isNavigatingAway = false; // Navigation trigger

  // Define target positions for each ingredient
  Map<String, Offset> ingredientTargets = {
    'meat': const Offset(0, 250),
    'onion': const Offset(0, 125),
    'spicy': const Offset(0, 0),
    'yogurt': const Offset(0, -125),
    'vegetables': const Offset(0, -250),
  };
  // State variable for the maximum distance
  double maxDistance = -1; // Initially unlimited
  Map<String, int> availableKebabs = {
  '200m': 0,
  '500m': 0,
  '1km': 0,
  '10km': 0,
  'unlimited': 0,
};


  // State variables for animations
  late AnimationController _ingredientController;
  late AnimationController _cloudController;
  late Animation<Offset> _cloudAnimation;
  bool showCloud = false;

  @override
void initState() {
  super.initState();
  List<int> profileIngredients = widget.ingredients ;
  
  setState(() {
    ingredientAmounts = {
      'meat': profileIngredients[0],
      'onion': profileIngredients[1],
      'spicy': profileIngredients[2],
      'yogurt': profileIngredients[3],
      'vegetables': profileIngredients[4],
    };
  });
  // Ingredient controller (for ingredient converging animation)
  _ingredientController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  // Cloud controller (for full-screen cloud appearance and movement from bottom)
  _cloudController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  // Slide animation for the cloud, starting from off-screen (below) to cover the full screen
  _cloudAnimation = Tween<Offset>(
    begin: const Offset(0, 1.5), // Start off-screen (below)
    end: Offset.zero, // End at the center (covering the whole screen)
  ).animate(_cloudController);

  // Fetch kebabs and calculate how many are in each distance range
  _fetchKebabAvailability();
}

void _fetchKebabAvailability() async {
  Map<String, int> availableKebabsPerRange =
      await calculateAvailableKebabsPerDistance(ingredientAmounts, widget.currentPosition);

  setState(() {
    availableKebabs = availableKebabsPerRange;
    
    // Set maxDistance to the first non-zero range
    if (availableKebabs['200m']! > 0) {
      maxDistance = 0.2;
    } else if (availableKebabs['500m']! > 0) {
      maxDistance = 0.5;
    } else if (availableKebabs['1km']! > 0) {
      maxDistance = 1;
    } else if (availableKebabs['10km']! > 0) {
      maxDistance = 10;
    } else {
      maxDistance = double.infinity; // Default to unlimited if all are 0
    }
  });
}


  @override
  void dispose() {
    _ingredientController.dispose();
    _cloudController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Build Your Kebab'),
    ),
    body: Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 650;

            return SingleChildScrollView(
              child: Center(
                child: isDesktop
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: ingredientAmounts.keys.map((ingredient) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: TweenAnimationBuilder<Offset>(
                                        tween: Tween<Offset>(
                                          begin: const Offset(0, 0),
                                          end: const Offset(0, 0),
                                        ),
                                        duration: const Duration(seconds: 1),
                                        builder: (context, value, child) {
                                          return Transform.translate(
                                            offset: value,
                                            child: IngredientControl(
                                              ingredientName: ingredient,
                                              amount: ingredientAmounts[ingredient]!,
                                              onAmountChanged: (amount) {
                                                setState(() {
                                                  ingredientAmounts[ingredient] = amount;
                                                  widget.onIngredientsUpdated(ingredientAmounts.values.toList());
                                                });
                                              },
                                              targetPosition: ingredientTargets[ingredient]!,
                                              isConverging: isConverging,
                                              isNavigatingAway: isNavigatingAway,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (String ingredient in ingredientAmounts.keys)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                ingredient,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Slider(
                                                value: ingredientAmounts[ingredient]!.toDouble(),
                                                min: 0,
                                                max: 10,
                                                divisions: 10,
                                                activeColor: red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    ingredientAmounts[ingredient] = value.toInt();
                                                    widget.onIngredientsUpdated(ingredientAmounts.values.toList());
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Distanza Massima',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      _buildDistanceSlider(),
                                      const SizedBox(height: 20), // Reduced space above button
                                      buildButton(),
                                      const SizedBox(height: 40), // Added margin below the button
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...ingredientAmounts.keys.map((ingredient) {
                            return Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: IngredientControl(
                                ingredientName: ingredient,
                                amount: ingredientAmounts[ingredient]!,
                                onAmountChanged: (amount) {
                                  setState(() {
                                    ingredientAmounts[ingredient] = amount;
                                    widget.onIngredientsUpdated(ingredientAmounts.values.toList());
                                  });
                                },
                                targetPosition: ingredientTargets[ingredient]!,
                                isConverging: isConverging,
                                isNavigatingAway: isNavigatingAway,
                              ),
                            ),
                              Text(
                                ingredientAmounts[ingredient]!.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ]);
                          }),

                          // Add the sliders and the "Build!" button back to mobile view
                          const SizedBox(height: 20),
                          const Text(
                            'Distanza Massima',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          _buildDistanceSlider(),
                          const SizedBox(height: 20), // Reduced space above button
                          buildButton(),
                          const SizedBox(height: 40), // Added margin below the button
                        ],
                      ),
              ),
            );
          },
        ),

        // Full screen cloud animation
        if (showCloud)
          SlideTransition(
            position: _cloudAnimation,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(
                  'assets/images/loading_cloud.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
      ],
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

String _getDistanceLabel(double distance) {
  if (distance <= 0.2) {
    return '200 metri (${availableKebabs['200m']} risultati)';
  } else if (distance <= 0.5) {
    return '500 metri (${availableKebabs['500m']} risultati)';
  } else if (distance <= 1) {
    return '1 km (${availableKebabs['1km']} risultati)';
  } else if (distance <= 10) {
    return '10 km (${availableKebabs['10km']} risultati)';
  } else {
    return 'Illimitato (${availableKebabs['unlimited']} risultati)';
  }
}


Widget buildButton() {
  return ElevatedButton(
    onPressed: () async {
      // Check if there are any available kebabs for the selected distance
      int availableKebabsForDistance = _getAvailableKebabsForCurrentDistance();

      // If no kebabs are available, show a SnackBar and don't trigger the cloud animation
      if (availableKebabsForDistance == 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nessun kebab corrispondente trovato nel raggio selezionato'),
            ),
          );
        }
        return; // Don't proceed further, no cloud animation
      }

      // Proceed with the cloud animation and convergence
      setState(() {
        isConverging = true;
      });
      _ingredientController.forward();
      await updateProfileIngredients();
      setState(() {  
  
        showCloud = true;  // Make the cloud appear
      });
      await _cloudController.forward();  // Slide cloud up

      // After cloud fully appears, process the build
      Future.delayed(const Duration(seconds: 1), () async {
        setState(() {
          isConverging = false;
          isNavigatingAway = true;
        });

        Map<String, dynamic>? result = await buildKebab(
          ingredientAmounts, 0, maxDistance, widget.currentPosition
        );
        Map<String, dynamic>? bestKebab;
        int availableKebabs = 0;

        if (result != null) {
          bestKebab = result['kebab'];
          availableKebabs = result['availableKebabs'];
        }

        if (bestKebab != null) {
          if (mounted) {
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
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Nessun kebab corrispondente trovato nel raggio selezionato'),
              ),
            );
          }
        }

        // Hide cloud after navigation
        setState(() {
          showCloud = false;  // Cloud slides back down
        });
        _cloudController.reverse();  // Slide cloud down
      });
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: red, // Red color for the button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Pill shape
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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

Future<void> updateProfileIngredients() async {
  List<int> selectedIngredients = [
    ingredientAmounts['meat']!,
    ingredientAmounts['onion']!,
    ingredientAmounts['spicy']!,
    ingredientAmounts['yogurt']!,
    ingredientAmounts['vegetables']!,
  ];

  // Call your updateProfile function (assuming you already have it in your utils)
  await updateProfile(context, null, null, selectedIngredients);
}

// Helper function to check available kebabs for the current maxDistance
int _getAvailableKebabsForCurrentDistance() {
  if (maxDistance <= 0.2) {
    return availableKebabs['200m'] ?? 0;
  } else if (maxDistance <= 0.5) {
    return availableKebabs['500m'] ?? 0;
  } else if (maxDistance <= 1) {
    return availableKebabs['1km'] ?? 0;
  } else if (maxDistance <= 10) {
    return availableKebabs['10km'] ?? 0;
  } else {
    return availableKebabs['unlimited'] ?? 0;
  }
}




  double _mapDistanceToSliderValue(double distance) {
    switch (distance) {
      case 0.2:
        return 0;
      case 0.5:
        return 1;
      case 1:
        return 2;
      case 10:
        return 3;
      default:
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
}
