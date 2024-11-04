import 'package:flutter/material.dart';

class IngredientControl extends StatefulWidget {
  final String ingredientName;
  final int amount; // Amount of the ingredient passed from parent
  final Function(int) onAmountChanged;
  final Offset
      targetPosition; // New target position for the convergence animation
  final bool isConverging; // To trigger the movement
  final bool isNavigatingAway; // New flag to check if navigating away

  const IngredientControl({
    super.key,
    required this.ingredientName,
    required this.onAmountChanged,
    required this.amount,
    required this.targetPosition,
    required this.isConverging,
    required this.isNavigatingAway, // New flag added
  });

  @override
  _IngredientControlState createState() => _IngredientControlState();
}

class _IngredientControlState extends State<IngredientControl>
    with SingleTickerProviderStateMixin {
  late int _amount;
  late Offset _currentPosition;
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _amount = widget.amount;

    // Initialize the current position of the ingredient (can be random or fixed)
    _currentPosition = const Offset(0, 0);

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Faster animation
      vsync: this,
    );

    // Define the position animation
    _positionAnimation = Tween<Offset>(
            begin: _currentPosition, end: widget.targetPosition)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // If convergence is already triggered, animate
    if (widget.isConverging) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant IngredientControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount != widget.amount) {
      _amount = widget.amount;
    }

    // Check if the convergence trigger has changed
    if (oldWidget.isConverging != widget.isConverging && widget.isConverging) {
      _controller.forward();
    } else if (!widget.isConverging) {
      // If convergence is canceled, bring back to the initial position with animation
      _controller.reverse();
    }

    // Handle navigation away case and instantly reset the position
    if (widget.isNavigatingAway && !oldWidget.isNavigatingAway) {
      _controller.stop(); // Stop any ongoing animations
      _controller.reset(); // Instantly reset to the initial position
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the sprite size based on the amount
    String spriteSize = _amount == 0
        ? ''
        : _amount <= 3
            ? 'small'
            : _amount <= 7
                ? 'medium'
                : 'large';

    // Construct the sprite path dynamically
    String spritePath = spriteSize.isEmpty
        ? '' // Empty path if amount is 0
        : 'images/${widget.ingredientName}_$spriteSize.png';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // - Button
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _amount > 0
              ? () {
                  setState(() {
                    _amount--;
                    widget.onAmountChanged(_amount);
                  });
                }
              : null,
        ),
/*
        // Sprite (conditionally display if spritePath is not empty)
        AnimatedBuilder(
          animation: _positionAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: _positionAnimation.value,
              child: spritePath.isNotEmpty
                  ? Image.asset(spritePath, width: 220, height: 100)
                  : null,
            );
          },
        ),
*/
        spritePath.isNotEmpty
            ? Image.asset(spritePath, width: 220, height: 100)
            : const SizedBox(width: 220, height: 100),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _amount < 10
              ? () {
                  setState(() {
                    _amount++;
                    widget.onAmountChanged(_amount);
                  });
                }
              : null,
        ),
      ],
    );
  }
}
