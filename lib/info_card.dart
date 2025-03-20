import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Elevation for shadow
      color: Colors.white, // Explicitly set background color to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Adjusted padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1), // Light blue background for the icon
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8.0), // Padding around the icon
              child: Icon(icon, size: 43, color: Colors.black), // Medium-sized icon
            ),
            const SizedBox(height: 2), // Adjusted spacing
            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), // Adjusted font size
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 1), // Adjusted spacing
            // Value
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold), // Adjusted font size
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
