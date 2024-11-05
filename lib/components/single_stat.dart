import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class SingleStat extends StatefulWidget {
  final String label;
  final double number;

  const SingleStat({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  SingleStatState createState() => SingleStatState();
}

class SingleStatState extends State<SingleStat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${widget.number}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: widget.number / 5,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(red),
          minHeight: 8,
          borderRadius: BorderRadius.circular(12),
        ),
      ],
    );
  }
}
