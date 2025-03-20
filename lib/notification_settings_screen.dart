import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  Map<String, bool> notifications = {
    "High voltage warnings": true,
    "Inverter Issues": true,
    "Weather Forecast": false,
    "Battery Low Warnings": true,
    "Energy Saving Suggestion": false,
    "Connection Help": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), // Add space at the top
            const Text("Push Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: notifications.keys.map((title) => _buildSwitchTile(title)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title) {
    return Column(
      children: [
        SwitchListTile(
          title: Text(title),
          value: notifications[title]!,
          onChanged: (bool value) {
            setState(() {
              notifications[title] = value;
            });
          },
        ),
        const Divider(),
      ],
    );
  }
}
