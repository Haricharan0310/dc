import 'package:flutter/material.dart';
import 'solar_power_card.dart';
import 'info_card.dart';
import 'notification_settings_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    NotificationSettingsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double solarPowerUsage = 0.0;
  double totalEnergy = 0.0;
  double consumed = 0.0;
  double capacity = 0.0;
  double pyranometer = 0.0;
  double temperature = 0.0;
  double efficiency = 0.0;
  bool isMainElectricity = false;
  String currentDate = "";

  @override
  void initState() {
    super.initState();
    currentDate = _getCurrentDate();
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString();
    final weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][now.weekday - 1];
    return "$weekday, $day/$month/$year";
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenContent(
      solarPowerUsage: solarPowerUsage,
      totalEnergy: totalEnergy,
      consumed: consumed,
      capacity: capacity,
      pyranometer: pyranometer,
      temperature: temperature,
      efficiency: efficiency,
      isMainElectricity: isMainElectricity,
      currentDate: currentDate,
    );
  }
}

class DashboardScreenContent extends StatelessWidget {
  final double solarPowerUsage;
  final double totalEnergy;
  final double consumed;
  final double capacity;
  final double pyranometer;
  final double temperature;
  final double efficiency;
  final bool isMainElectricity;
  final String currentDate;

  const DashboardScreenContent({
    super.key,
    required this.solarPowerUsage,
    required this.totalEnergy,
    required this.consumed,
    required this.capacity,
    required this.pyranometer,
    required this.temperature,
    required this.efficiency,
    required this.isMainElectricity,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40), // Add space at the top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hi Charlie", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(currentDate, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              // Comment out the switch
              // Switch(
              //   value: isMainElectricity,
              //   onChanged: (value) {
              //     setState(() {
              //       isMainElectricity = value;
              //     });
              //   },
              // )
            ],
          ),
          const SizedBox(height: 20),
          SolarPowerCard(
            value: solarPowerUsage,
            percentage: 40,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                InfoCard(title: "Total energy", value: totalEnergy, icon: Icons.lightbulb),
                InfoCard(title: "Consumed", value: consumed, icon: Icons.refresh),
                InfoCard(title: "Capacity", value: capacity, icon: Icons.storage),
                InfoCard(title: "Pyranometer", value: pyranometer, icon: Icons.loop),
                InfoCard(title: "Temperature", value: temperature, icon: Icons.thermostat),
                InfoCard(title: "Efficiency", value: efficiency, icon: Icons.show_chart_outlined),
              ],
            ),
          )
        ],
      ),
    );
  }
}
