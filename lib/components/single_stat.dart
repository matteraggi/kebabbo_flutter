import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class SingleStat extends StatefulWidget {
  final String label;
  final double number;

  const SingleStat({
    required this.label,
    required this.number,
  });

  @override
  _SingleStatState createState() => _SingleStatState();
}

class _SingleStatState extends State<SingleStat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.number}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: widget.number / 5,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(red),
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }
}
