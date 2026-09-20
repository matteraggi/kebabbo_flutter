import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/animations/kebab_cooking_overlay.dart';
import 'package:kebabbo_flutter/components/list_items/ingredient_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab/kebab_recommandation_page.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:kebabbo_flutter/utils/ingredients_logic.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class ToolsPage extends StatefulWidget {
  final Position? currentPosition;
  final List<int> ingredients;
  final Function(List<int>)
      onIngredientsUpdated; // Callback for updating ingredients

  const ToolsPage(
      {super.key,
      required this.currentPosition,
      required this.ingredients,
      required this.onIngredientsUpdated});

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
  bool _isBuilding = false;

  @override
  void initState() {
    super.initState();
    List<int> profileIngredients = widget.ingredients;

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

    // Fetch kebabs and calculate how many are in each distance range
    _fetchKebabAvailability();
  }

  void _fetchKebabAvailability() async {
    Map<String, int> availableKebabsPerRange =
        await calculateAvailableKebabsPerDistance(
            ingredientAmounts, widget.currentPosition);

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

  // Helper to get localized names
  String _getLocalizedIngredientName(String key) {
    switch (key) {
      case 'meat':
        return S.of(context).meat;
      case 'onion':
        return S.of(context).onion;
      case 'spicy':
        return S.of(context).spicy;
      case 'yogurt':
        return S.of(context).yogurt;
      case 'vegetables':
        return S.of(context).vegetables;
      default:
        return key;
    }
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).build_your_kebab),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isDesktop = constraints.maxWidth > 650;
              final double availableHeight = constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : 650.0;
              final double itemHeight =
                  (availableHeight * 0.096).clamp(56.0, 80.0);

              if (isDesktop) {
                return SingleChildScrollView(
                  physics: availableHeight > 600
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: availableHeight),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: ingredientAmounts.keys
                                      .map((ingredient) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
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
                                              itemHeight: itemHeight,
                                              amount: ingredientAmounts[
                                                  ingredient]!,
                                              onAmountChanged: (amount) {
                                                setState(() {
                                                  ingredientAmounts[
                                                      ingredient] = amount;
                                                  widget.onIngredientsUpdated(
                                                      ingredientAmounts.values
                                                          .toList());
                                                });
                                              },
                                              targetPosition:
                                                  ingredientTargets[
                                                      ingredient]!,
                                              isConverging: isConverging,
                                              isNavigatingAway:
                                                  isNavigatingAway,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      for (String ingredient
                                          in ingredientAmounts.keys)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                _getLocalizedIngredientName(
                                                    ingredient),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Slider(
                                                value: ingredientAmounts[
                                                        ingredient]!
                                                    .toDouble(),
                                                min: 0,
                                                max: 10,
                                                divisions: 10,
                                                activeColor: red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    ingredientAmounts[
                                                            ingredient] =
                                                        value.toInt();
                                                    widget.onIngredientsUpdated(
                                                        ingredientAmounts.values
                                                            .toList());
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 20),
                                      Text(
                                        S.of(context).distanza_massima,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      _buildDistanceSlider(),
                                      const SizedBox(height: 20),
                                      buildButton(),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Mobile Layout: fills screen height gracefully without empty spaces or scrolling
              final Widget mobileContent = Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    for (final ingredient in ingredientAmounts.keys)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IngredientControl(
                                ingredientName: ingredient,
                                itemHeight: itemHeight,
                                amount: ingredientAmounts[ingredient]!,
                                onAmountChanged: (amount) {
                                  setState(() {
                                    ingredientAmounts[ingredient] = amount;
                                    widget.onIngredientsUpdated(
                                        ingredientAmounts.values.toList());
                                  });
                                },
                                targetPosition:
                                    ingredientTargets[ingredient]!,
                                isConverging: isConverging,
                                isNavigatingAway: isNavigatingAway,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _getLocalizedIngredientName(ingredient),
                                style: TextStyle(
                                  fontSize: (itemHeight * 0.22)
                                      .clamp(12.0, 15.0),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Distance section and Build button
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.of(context).distanza_massima,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          _buildDistanceSlider(),
                          const SizedBox(height: 4),
                          buildButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              );

              return availableHeight > 540
                  ? SizedBox(
                      height: availableHeight,
                      child: mobileContent,
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        height: 560,
                        child: mobileContent,
                      ),
                    );
            },
          ),

          // Modern, sizzling Kebab Cooking Overlay
          KebabCookingOverlay(
            isVisible: _isBuilding,
            ingredients: ingredientAmounts,
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
      return S
          .of(context)
          .distanceLabel200m(availableKebabs['200m'].toString());
    } else if (distance <= 0.5) {
      return S
          .of(context)
          .distanceLabel500m(availableKebabs['500m'].toString());
    } else if (distance <= 1) {
      return S.of(context).distanceLabel1km(availableKebabs['1km'].toString());
    } else if (distance <= 10) {
      return S
          .of(context)
          .distanceLabel10km(availableKebabs['10km'].toString());
    } else {
      return S
          .of(context)
          .distanceLabelUnlimited(availableKebabs['unlimited'].toString());
    }
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: _isBuilding
          ? null
          : () async {
              // Check if there are any available kebabs for the selected distance
              int availableKebabsForDistance =
                  _getAvailableKebabsForCurrentDistance();

              // If no kebabs are available, show a SnackBar
              if (availableKebabsForDistance == 0) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S
                          .of(context)
                          .nessun_kebab_corrispondente_trovato_nel_raggio_selezionato),
                    ),
                  );
                }
                return;
              }

              // Proceed with the cooking overlay & ingredient convergence
              setState(() {
                _isBuilding = true;
                isConverging = true;
              });
              _ingredientController.forward();
              await updateProfileIngredients();

              // Run buildKebab concurrently with minimum cooking animation time
              final results = await Future.wait([
                buildKebab(ingredientAmounts, 0, maxDistance, widget.currentPosition),
                Future.delayed(const Duration(milliseconds: 2000)),
              ]);

              final result = results[0] as Map<String, dynamic>?;
              Map<String, dynamic>? bestKebab;
              int availableKebabs = 0;

              if (result != null) {
                bestKebab = result['kebab'];
                availableKebabs = result['availableKebabs'];
              }

              if (bestKebab != null && mounted) {
                setState(() {
                  isConverging = false;
                  isNavigatingAway = true;
                });

                await Navigator.push(
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

                if (mounted) {
                  setState(() {
                    _isBuilding = false;
                    isNavigatingAway = false;
                  });
                  _ingredientController.reset();
                }
              } else if (mounted) {
                setState(() {
                  _isBuilding = false;
                  isConverging = false;
                });
                _ingredientController.reverse();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S
                        .of(context)
                        .nessun_kebab_corrispondente_trovato_nel_raggio_selezionato),
                  ),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        foregroundColor: red, // Red color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Pill shape
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        S.of(context).build_button, // Updated to use S.of(context)
        style: const TextStyle(
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
