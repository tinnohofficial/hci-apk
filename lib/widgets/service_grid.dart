// lib/widgets/service_grid.dart
import 'package:flutter/material.dart';
import 'package:hci/screens/send_money_screen.dart'; //added package path
import 'package:hci/screens/pay_bill_screen.dart'; //added package path
import 'package:hci/screens/cash_out_screen.dart'; //added package path
import 'package:hci/screens/airtime_screen.dart'; //added package path
import 'package:hci/widgets/service_card.dart'; // Import the ServiceCard widget

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16, // Add spacing between cards
      mainAxisSpacing: 16, // Add spacing between cards
      children: [
        ServiceCard(
          icon: Icons.send,
          title: 'Send Money',
          subtitle: 'AI-powered safe transfers',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
          ),
        ),
        ServiceCard(
          icon: Icons.receipt_long,
          title: 'Pay Bills',
          subtitle: 'Smart bill payments',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PayBillScreen()),
          ),
        ),
        ServiceCard(
          icon: Icons.account_balance,
          title: 'Cash Out',
          subtitle: 'Find nearest agent',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CashOutScreen()),
          ),
        ),
        ServiceCard(
          icon: Icons.phone_android,
          title: 'Airtime & Bundles',
          subtitle: 'Smart recommendations',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AirtimeScreen()),
          ),
        ),
      ],
    );
  }
}
