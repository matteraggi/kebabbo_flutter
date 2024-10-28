import 'package:flutter/material.dart';
class IngredientControl extends StatefulWidget {
  final String ingredientName;
  final int amount; // Amount of the ingredient passed from parent
  final Function(int) onAmountChanged;

  const IngredientControl({
    super.key,
    required this.ingredientName,
    required this.onAmountChanged,
    required this.amount,
  });

  @override
  _IngredientControlState createState() => _IngredientControlState();
}

class _IngredientControlState extends State<IngredientControl> {
  late int _amount;

  @override
  void initState() {
    super.initState();
    _amount = widget.amount;
  }

  @override
  void didUpdateWidget(covariant IngredientControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _amount = widget.amount;
    }
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
        : 'images/${widget.ingredientName}/$spriteSize.png';

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

        // Sprite (conditionally display if spritePath is not empty)
        SizedBox(
          width: 220, // Increased width
          height: 100, // Increased height
          child: spritePath.isNotEmpty
              ? Image.asset(
                  spritePath,
                  fit: BoxFit.cover, // This makes the image fill the box while preserving aspect ratio
                )
              : null,
        ),

        // + Button
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
