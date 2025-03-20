import 'package:flutter/material.dart';
import 'solar_power_card.dart';
import 'info_card.dart';
import 'notification_settings_screen.dart';
import 'settings_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Set SplashScreen as the initial screen
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 168, 243, 246), // Set default background color to white
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A3A72), Color(0x59ADB0)], // Gradient with #163560
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.flash_on, size: 100, color: Colors.white), // Example icon
              SizedBox(height: 20),
              Text(
                "Power Monitor",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
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
      backgroundColor: Colors.white, // Set the background color to pure white
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), // Rounded corner on the top-left
            topRight: Radius.circular(16), // Rounded corner on the top-right
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white, // Set navigation bar color to white
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Ensure child widgets have white backgrounds
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
  double acEnergy = 0.0; // Renamed from totalEnergy
  double acVoltage = 0.0; // Renamed from consumed
  double dcLinkVoltage = 0.0; // Renamed from capacity
  double pyranometer = 0.0;
  double temperature = 0.0;
  double powerFactor = 0.0; // Renamed from efficiency
  double energyToday = 0.0; // State for Energy Today
  double outputCurrent = 0.0; // State for Output Current
  double totalEnergy = 0.0; // State for Total Energy
  double outputPower = 0.0; // State for Output Power
  double dcCurrent = 0.0; // New state for DC Current
  bool isMainElectricity = false;
  String currentDate = "";

  @override
  void initState() {
    super.initState();
    currentDate = _getCurrentDate();

    // Use the formatted date and time for the API call
    fetchForecastData(currentDate);
  }

  Future<void> fetchForecastData(String dateTime) async {
    final url = Uri.parse('https://brilliant-pet-dc-generator-564a35fd.koyeb.app/forecast');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'forecast_date': dateTime}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Update state variables with the response data
        setState(() {
          solarPowerUsage = data['predicted_dc_power'] ?? 0.0; // Predicted DC Power
          acEnergy = data['features']['Energy today'] ?? 0.0; // Energy Today
          acVoltage = data['features']['AC voltage'] ?? 0.0; // AC Voltage
          dcLinkVoltage = data['features']['DCLink Voltage'] ?? 0.0; // DCLink Voltage
          pyranometer = data['features']['Pyranometer'] ?? 0.0; // Pyranometer
          temperature = data['features']['Temperature'] ?? 0.0; // Temperature
          powerFactor = data['features']['Power Factor'] ?? 0.0; // Power Factor
          energyToday = data['features']['Energy today'] ?? 0.0; // Energy Today
          outputCurrent = data['features']['Output current'] ?? 0.0; // Output Current
          totalEnergy = data['features']['Total Energy'] ?? 0.0; // Total Energy
          outputPower = data['features']['output power'] ?? 0.0; // Output Power
          dcCurrent = data['features']['DC Current'] ?? 0.0; // DC Current
        });
      } else {
        throw Exception('Failed to fetch forecast data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0'); // Ensure 2-digit month
    final day = now.day.toString().padLeft(2, '0'); // Ensure 2-digit day
    final hour = now.hour.toString().padLeft(2, '0'); // Ensure 2-digit hour
    final minute = now.minute.toString().padLeft(2, '0'); // Ensure 2-digit minute
    final second = now.second.toString().padLeft(2, '0'); // Ensure 2-digit second

    // Return the formatted date and time
    return "$year-$month-$day $hour:$minute:$second";
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenContent(
      solarPowerUsage: solarPowerUsage,
      acEnergy: acEnergy,
      acVoltage: acVoltage,
      dcLinkVoltage: dcLinkVoltage,
      pyranometer: pyranometer,
      temperature: temperature,
      powerFactor: powerFactor,
      energyToday: energyToday,
      outputCurrent: outputCurrent,
      totalEnergy: totalEnergy,
      outputPower: outputPower,
      dcCurrent: dcCurrent, // Pass the new state
      isMainElectricity: isMainElectricity,
      currentDate: currentDate,
    );
  }
}

class DashboardScreenContent extends StatelessWidget {
  final double solarPowerUsage;
  final double acEnergy; // Renamed from totalEnergy
  final double acVoltage; // Renamed from consumed
  final double dcLinkVoltage; // Renamed from capacity
  final double pyranometer;
  final double temperature;
  final double powerFactor; // Renamed from efficiency
  final double energyToday; // New parameter for Energy Today
  final double outputCurrent; // New parameter for Output Current
  final double totalEnergy; // New parameter for Total Energy
  final double outputPower; // New parameter for Output Power
  final double dcCurrent; // New parameter for DC Current
  final bool isMainElectricity;
  final String currentDate;

  const DashboardScreenContent({
    super.key,
    required this.solarPowerUsage,
    required this.acEnergy, // Updated parameter
    required this.acVoltage, // Updated parameter
    required this.dcLinkVoltage, // Updated parameter
    required this.pyranometer,
    required this.temperature,
    required this.powerFactor, // Updated parameter
    required this.energyToday, // New parameter
    required this.outputCurrent, // New parameter
    required this.totalEnergy, // New parameter
    required this.outputPower, // New parameter
    required this.dcCurrent, // New parameter
    required this.isMainElectricity,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Explicitly set the background color to white
      child: Padding(
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
                    Text(currentDate, style: const TextStyle(fontSize: 16, color: Colors.grey)), // Display date and time
                  ],
                ),
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
                  InfoCard(title: "Predicted DC Power", value: solarPowerUsage, icon: Icons.flash_on),
                  InfoCard(title: "AC Voltage", value: acVoltage, icon: Icons.electrical_services),
                  InfoCard(title: "DCLink Voltage", value: dcLinkVoltage, icon: Icons.battery_charging_full),
                  InfoCard(title: "Energy Today", value: energyToday, icon: Icons.bolt),
                  InfoCard(title: "Output Current", value: outputCurrent, icon: Icons.electrical_services),
                  InfoCard(title: "Total Energy", value: totalEnergy, icon: Icons.battery_full),
                  InfoCard(title: "Output Power", value: outputPower, icon: Icons.power),
                  InfoCard(title: "DC Current", value: dcCurrent, icon: Icons.flash_on),
                  InfoCard(title: "Pyranometer", value: pyranometer, icon: Icons.wb_sunny),
                  InfoCard(title: "Temperature", value: temperature, icon: Icons.thermostat),
                  InfoCard(title: "Power Factor", value: powerFactor, icon: Icons.show_chart),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
