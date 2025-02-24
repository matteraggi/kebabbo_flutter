import 'package:flutter/material.dart';
import 'dart:math';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';

class SingleCard extends StatefulWidget {
  final String imagePath; // Pass image path to the spinning card
  const SingleCard({super.key, required this.imagePath});

  @override
  SingleCardState createState() => SingleCardState();
}

class SingleCardState extends State<SingleCard> {
  double tiltAngle = 0.0; // Tracks tilt angle (side-to-side)
  final double maxTiltAngle = pi / 7; // Limit to ~25° in radians

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Update the tilt angle based on horizontal drag
          tiltAngle += details.delta.dx * 0.01; // Adjust sensitivity

          // Clamp the tilt angle to be within ±maxTiltAngle (~25°)
          tiltAngle = tiltAngle.clamp(-maxTiltAngle, maxTiltAngle);
        });
      },
      child: Scaffold(
        appBar: AppBar(title:  Text(S.of(context).single_card)),
        body: Container(
          // Apply the black-to-white gradient background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ Colors.white, red],
              stops: [0, 1],
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50), // Add padding to prevent cutting
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY(tiltAngle), // Apply the tilt rotation along y-axis
                child: Container(
                  width: 275, // Increased size for the card
                  height: 700, // Adjusted height to avoid cutting
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.imagePath, // Display the passed image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
