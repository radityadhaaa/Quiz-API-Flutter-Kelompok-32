import 'package:flutter/material.dart';

class DistanceText extends StatelessWidget {
  final double distance;

  const DistanceText({
    super.key,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${distance.toStringAsFixed(2)} km',
      style: const TextStyle(
        color: Color.fromARGB(255, 119, 119, 119),
        fontSize: 16,
      ),
    );
  }
}
