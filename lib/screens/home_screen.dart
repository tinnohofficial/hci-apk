// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:hci/widgets/service_grid.dart'; //added package path
import 'package:hci/widgets/quick_actions.dart'; //added package path

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group21 AI Mobile Money'),
      ),
      body: Column(
        children: [
          const BalanceWidget(), // Make this const
          const Expanded(
            child: ServiceGrid(),
          ),
          const QuickActions(), // Make this const
        ],
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual balance retrieval
    const balance = '12,000/=';

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orange[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Available Balance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            balance,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
