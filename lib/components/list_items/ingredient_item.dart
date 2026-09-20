import 'package:flutter/material.dart';

class IngredientControl extends StatefulWidget {
  final String ingredientName;
  final int amount;
  final Function(int) onAmountChanged;
  final Offset targetPosition;
  final bool isConverging;
  final bool isNavigatingAway;
  final double itemHeight;

  const IngredientControl({
    super.key,
    required this.ingredientName,
    required this.onAmountChanged,
    required this.amount,
    required this.targetPosition,
    required this.isConverging,
    required this.isNavigatingAway,
    this.itemHeight = 60.0,
  });

  @override
  IngredientControlState createState() => IngredientControlState();
}

class IngredientControlState extends State<IngredientControl>
    with SingleTickerProviderStateMixin {
  late int _amount;
  late Offset _currentPosition;
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _amount = widget.amount;
    _currentPosition = const Offset(0, 0);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _positionAnimation = Tween<Offset>(
            begin: _currentPosition, end: widget.targetPosition)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isConverging) {
      _controller.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now it's safe to use context-dependent code, like MediaQuery
    _preloadImages();
  }

  // Preload all image sizes to cache them in memory
  void _preloadImages() {
    List<String> sizes = ['small', 'medium', 'large'];

    for (var size in sizes) {
      String spritePath = 'assets/images/${widget.ingredientName}_$size.png';
      precacheImage(AssetImage(spritePath), context);
    }
  }

  @override
  void didUpdateWidget(covariant IngredientControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount != widget.amount) {
      _amount = widget.amount;
    }

    if (oldWidget.isConverging != widget.isConverging && widget.isConverging) {
      _controller.forward();
    } else if (!widget.isConverging) {
      _controller.reverse();
    }

    if (widget.isNavigatingAway && !oldWidget.isNavigatingAway) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String spriteSize = _amount == 0
        ? ''
        : _amount <= 3
            ? 'small'
            : _amount <= 7
                ? 'medium'
                : 'large';

    String spritePath = spriteSize.isEmpty
        ? ''
        : 'assets/images/${widget.ingredientName}_$spriteSize.png';

    final double itemWidth = widget.itemHeight * 2.2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          iconSize: (widget.itemHeight * 0.38).clamp(18.0, 24.0),
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
          onPressed: _amount > 0
              ? () {
                  setState(() {
                    _amount--;
                    widget.onAmountChanged(_amount);
                  });
                }
              : null,
        ),
        AnimatedBuilder(
          animation: _positionAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: _positionAnimation.value,
              child: spritePath.isNotEmpty
                  ? Image.asset(
                      spritePath,
                      width: itemWidth,
                      height: widget.itemHeight,
                      gaplessPlayback: true, // Ensures smooth transition
                      excludeFromSemantics: true, // Optional, for performance
                    )
                  : SizedBox(width: itemWidth, height: widget.itemHeight),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          iconSize: (widget.itemHeight * 0.38).clamp(18.0, 24.0),
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
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
