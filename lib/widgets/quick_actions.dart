// lib/widgets/quick_actions.dart

import 'package:flutter/material.dart';
import 'package:hci/screens/send_money_screen.dart'; //added package path
import 'package:hci/screens/airtime_screen.dart'; //added package path

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickActionButton(
            context,
            Icons.send,
            'Send',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SendMoneyScreen())),
          ),
          _buildQuickActionButton(
            context,
            Icons.phone_android,
            'Airtime',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AirtimeScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange[100],
            child: Icon(icon, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
