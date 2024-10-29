import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/ingredient_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab_recommandation_page.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

class ToolsPage extends StatefulWidget {
  final Position? currentPosition;

  const ToolsPage({super.key, required this.currentPosition});

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
    'meat': const Offset(300, 200),
    'onion': const Offset(300, 100),
    'spicy': const Offset(300, 0),
    'yogurt': const Offset(300, -100),
    'vegetables': const Offset(300, -200),
  };
  // State variable for the maximum distance
  double maxDistance = 1; // Initially unlimited

  // State variables for animations
  late AnimationController _ingredientController;
  late AnimationController _cloudController;
  late Animation<Offset> _cloudAnimation;
  bool showCloud = false;

  @override
  void initState() {
    super.initState();

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

              return Center(
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
                                        ), // Adjust the final position to converge towards center
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
                                                });
                                              },

                                              targetPosition: ingredientTargets[ingredient]!,
                                              isConverging: isConverging, // Pass the convergence trigger
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
                                      const SizedBox(height: 30),
                                      buildButton(),
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
                          children: ingredientAmounts.keys.map((ingredient) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: IngredientControl(
                                ingredientName: ingredient,
                                amount: ingredientAmounts[ingredient]!,
                                onAmountChanged: (amount) {
                                  setState(() {
                                    ingredientAmounts[ingredient] = amount;
                                  });
                                },

                                targetPosition: ingredientTargets[ingredient]!,
                                isConverging: isConverging, // Pass the convergence trigger
                                isNavigatingAway: isNavigatingAway,
                              ),
                            );
                          }).toList(),
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
                    'images/loading_cloud.png',
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

  // Widget for the Build button
  Widget buildButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isConverging = true;
        });
        // Trigger ingredient convergence animation
        _ingredientController.forward();

        // After convergence, show the cloud
          setState(() {
            showCloud = true;
          });
          _cloudController.forward();

          // After cloud fully appears, navigate to the recommendation page
          Future.delayed(const Duration(seconds: 1), () async {
            setState(() {
              isConverging = false;
              isNavigatingAway = true;
            });
            Map<String, dynamic>? result = await buildKebab(ingredientAmounts, 0, maxDistance, widget.currentPosition);
            Map<String, dynamic>? bestKebab;
            int availableKebabs = 0;
            if (result != null) {
              bestKebab = result['kebab'];
              availableKebabs = result['availableKebabs'];
            }

            if (bestKebab != null) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nessun kebab corrispondente trovato nel raggio selezionato')),
              );
            }

            // Hide cloud after navigation
            setState(() {
              showCloud = false;
            });
            _cloudController.reverse();
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
