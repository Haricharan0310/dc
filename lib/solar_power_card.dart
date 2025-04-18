import 'package:flutter/material.dart';

class SolarPowerCard extends StatelessWidget {
  final double value;
  // final double percentage; // Commented out

  const SolarPowerCard({super.key, required this.value /*, required this.percentage*/});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Align the text and card in the center
      children: [
        // Title outside the card
        const Text(
          "Predicted DC Output",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center, // Align text in the center
        ),
        const SizedBox(height: 12), // Spacing between the title and the card
        // Solar Power Card
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12), // Reduced padding from 16 to 12
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text("${value.abs().toStringAsFixed(3)} KWh", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8), // Reduced spacing
                  const Text("Solar Power Usage", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4), // Reduced spacing
                  LinearProgressIndicator(
                    // value: percentage / 100, // Commented out
                    // color: const Color(0xFF3C798D),
                    // backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8, // Position from the top
              right: 12, // Position from the right
              child: Text(
                "-", // Provide a default text value
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
