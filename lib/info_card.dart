import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;

  const InfoCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Set a fixed width
      height: 140, // Set a fixed height
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.black87), // Reduced icon size
          const SizedBox(height: 8), // Reduced spacing
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)), // Reduced font size
          const SizedBox(height: 4), // Reduced spacing
          Text("${value.toStringAsFixed(1)} Kwh", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), // Reduced font size
        ],
      ),
    );
  }
}
