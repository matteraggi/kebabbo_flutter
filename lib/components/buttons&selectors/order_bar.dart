import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class OrderBar extends StatefulWidget {
  final bool showStaffRatings;
  final VoidCallback onToggleShowStaffRatings;

  const OrderBar({
    super.key,
    required this.showStaffRatings,
    required this.onToggleShowStaffRatings,
  });

  @override
  State<OrderBar> createState() => _OrderBarState();
}

class _OrderBarState extends State<OrderBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.showStaffRatings) {
      _controller.value = 0.0;
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant OrderBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showStaffRatings != oldWidget.showStaffRatings) {
      widget.showStaffRatings ? _controller.reverse() : _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTab({
    required bool isActive,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isActive ? red : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.black54,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            children: [
              // Indicator animato dietro il tab attivo
              LayoutBuilder(
                builder: (context, constraints) {
                  final tabWidth = constraints.maxWidth / 2;
                  return Transform.translate(
                    offset: Offset(tabWidth * _controller.value, 0),
                    child: Container(
                      width: tabWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  _buildTab(
                    isActive: widget.showStaffRatings,
                    icon: Icons.workspace_premium,
                    text: "Staff",
                    onTap: () {
                      if (!widget.showStaffRatings) {
                        widget.onToggleShowStaffRatings();
                      }
                    },
                  ),
                  _buildTab(
                    isActive: !widget.showStaffRatings,
                    icon: Icons.people_alt_outlined,
                    text: "Users",
                    onTap: () {
                      if (widget.showStaffRatings) {
                        widget.onToggleShowStaffRatings();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
