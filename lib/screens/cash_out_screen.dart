// lib/screens/cash_out_screen.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({super.key});

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  final _agentController = TextEditingController();
  final _amountController = TextEditingController();
  List<Map<String, dynamic>> _nearbyAgents = [];
  String _currentAddress = 'Loading...'; // Store current address

  @override
  void initState() {
    super.initState();
    _loadNearbyAgents();
    _getCurrentLocation(); // Get location on startup
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case where services are disabled
      setState(() {
        _currentAddress = 'Location services are disabled.';
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle case where permissions are denied
        setState(() {
          _currentAddress = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle case where permissions are permanently denied
      setState(() {
        _currentAddress =
            'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }
    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // Get address from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.locality}, ${place.postalCode}';
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = 'Could not determine location.';
      });
    }
  }

  Future<void> _loadNearbyAgents() async {
    // Simulate loading nearby agents (Replace with your actual agent data)
    // In a real app, you'd fetch this from a backend, likely using
    // the user's location to filter agents.
    setState(() {
      _nearbyAgents = [
        {
          'name': 'Agent John',
          'id': 'A123',
          'distance': '0.2km',
          'rating': 4.8,
          'location': {'latitude': -6.8160, 'longitude': 39.2790},
        }, //Dar es Salaam Coordinates
        {
          'name': 'Agent Mary',
          'id': 'A456',
          'distance': '0.5km',
          'rating': 4.5,
          'location': {'latitude': -6.8170, 'longitude': 39.2800}
        }, //Dar es Salaam Coordinates
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cash Out')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display current address
            Text(
              'Your Location: $_currentAddress',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            const Text(
              'Nearby Agents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _nearbyAgents.length,
                itemBuilder: (context, index) {
                  final agent = _nearbyAgents[index];
                  return Card(
                    child: ListTile(
                      title: Text(agent['name']),
                      subtitle:
                          Text('ID: ${agent['id']} • ${agent['distance']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text('${agent['rating']}'),
                        ],
                      ),
                      onTap: () => _showCashOutDialog(agent),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCashOutDialog(Map<String, dynamic> agent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cash Out with ${agent['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Text('Agent ID: ${agent['id']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement cash out logic
              if (_amountController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cashout successful!")));
                _amountController.clear();
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Enter amount.")));
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
