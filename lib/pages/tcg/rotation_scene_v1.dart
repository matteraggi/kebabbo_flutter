import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/tcg/single_card.dart';
class RotationSceneV1 extends StatefulWidget {
  final List<String> imagePaths;
  const RotationSceneV1({super.key, required this.imagePaths});

  @override
  RotationSceneV1State createState() => RotationSceneV1State();
}

class RotationSceneV1State extends State<RotationSceneV1> {
  double rotationOffset = 0.0; // Tracks rotation due to drag

    @override
  void initState() {
    super.initState();

    // Calculate initial offset to center the first card
    _setInitialRotationOffset(); 
  }

  void _setInitialRotationOffset() {
    // Set the initial rotation offset
    setState(() {
      rotationOffset = pi / widget.imagePaths.length; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Reverse drag direction
          rotationOffset -= details.delta.dx * 0.005;
        });
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [yellow, Colors.white],
              stops: [0, 1],
            ),
          ),
          child: Center(
            child: MyScener(imagePaths: widget.imagePaths, rotationOffset: rotationOffset),
          ),
        ),
      ),
    );
  }
}



// MyScener widget (carousel scene) modification
class MyScener extends StatefulWidget {
  final List<String> imagePaths;
  final double rotationOffset;

  const MyScener({super.key, required this.imagePaths, required this.rotationOffset});

  @override
  MyScenerState createState() => MyScenerState();
}

class MyScenerState extends State<MyScener> with SingleTickerProviderStateMixin {
  List<CardData> cardData = [];
  late int numItems;
  double radio = 200.0;
  late double radioStep;

  @override
  void initState() {
    super.initState();
    numItems = widget.imagePaths.length;
    radioStep = (pi * 2) / numItems;
    cardData = List.generate(numItems, (index) => CardData(index));
  }

  @override
  Widget build(BuildContext context) {
    // Update positions with the current rotation offset
    for (var i = 0; i < cardData.length; ++i) {
      var c = cardData[i];
      double ang = c.idx * radioStep + widget.rotationOffset;
      c.angle = ang + pi / 2;
      c.x = cos(ang) * radio;
      c.y = sin(ang) * 100;
      c.z = sin(ang) * radio;
    }

    // Sort by z-index for proper stacking
    cardData.sort((a, b) => a.z.compareTo(b.z));

    var list = cardData.map((vo) {
      var c = addCard(vo); // The method below handles tap for each card
      var mt2 = Matrix4.identity();
      mt2.setEntry(3, 2, 0.001); // Perspective effect
      mt2.translate(vo.x, vo.y, -vo.z);

      double scale = 1 + (vo.z / radio) * 0.5;
      mt2.scale(scale, scale); // Scaling for perspective

      c = Transform(
        alignment: Alignment.center,
        transform: mt2,
        child: c,
      );
      return c;
    }).toList();

    return Transform.translate(
      offset: const Offset(0, -80), // Adjust this value as needed
      child: Stack(
        alignment: Alignment.center,
        children: list,
      ),
    );
  }

  // Modify addCard to handle tap and navigation
  Widget addCard(CardData vo) {
    var alpha = ((1 - vo.z / radio) / 2) * .6;
    return GestureDetector(
      onTap: () {
        // Navigate to SpinningCard page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleCard(imagePath: widget.imagePaths[vo.idx % widget.imagePaths.length]),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        width: 150,
        height: 200,
        alignment: Alignment.center,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(0, 0, 0, alpha),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.imagePaths[vo.idx % widget.imagePaths.length],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class CardData {
  late Color color;
  late double x, y, z, angle;
  final int idx;
  double alpha = 0;

  Color get lightColor {
    var val = HSVColor.fromColor(color);
    return val.withSaturation(.5).withValue(.8).toColor();
  }

  CardData(this.idx) {
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
    angle = 0;
  }
}
