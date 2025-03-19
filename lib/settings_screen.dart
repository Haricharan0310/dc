import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), // Add space at the top
            const Text("Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  SettingsTile(icon: Icons.person, title: "Account"),
                  SettingsTile(icon: Icons.solar_power, title: "Solar Details"),
                  SettingsTile(icon: Icons.email, title: "Contact Us"),
                  SettingsTile(icon: Icons.description, title: "Terms & Conditions"),
                  SettingsTile(icon: Icons.lock, title: "Privacy Policy"),
                  SettingsTile(icon: Icons.info, title: "About"),
                  SettingsTile(icon: Icons.logout, title: "Logout"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black87),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
