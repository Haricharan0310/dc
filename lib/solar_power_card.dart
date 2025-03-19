import 'package:flutter/material.dart';

class SolarPowerCard extends StatelessWidget {
  final double value;
  final double percentage;
  const SolarPowerCard({super.key, required this.value, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Text("${value.toStringAsFixed(3)}KWh", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Solar Power Usage", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: percentage / 100, color: Colors.orange, backgroundColor: Colors.grey.shade300),
        ],
      ),
    );
  }
}
