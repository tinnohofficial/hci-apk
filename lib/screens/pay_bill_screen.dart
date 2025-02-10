// lib/screens/pay_bill_screen.dart
import 'package:flutter/material.dart';
import 'package:hci/services/ai_service.dart';

class PayBillScreen extends StatefulWidget {
  const PayBillScreen({super.key});

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  final _billTypeController = TextEditingController();
  final _accountNumberController =
      TextEditingController(); // Added account number
  final _amountController = TextEditingController();
  String? _aiRecommendation;
  final _aiService = AIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bills')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _billTypeController,
              decoration: const InputDecoration(
                labelText: 'Bill Type (e.g., Electricity, Water)',
                prefixIcon: Icon(Icons.receipt),
              ),
              onChanged: (_) => _getAiRecommendations(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                prefixIcon: Icon(Icons.account_box),
              ),
              keyboardType:
                  TextInputType.number, // Assuming account numbers are numeric
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            if (_aiRecommendation != null) ...[
              const SizedBox(height: 16),
              _buildAiRecommendationCard(),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement bill payment logic
                if (_billTypeController.text.isNotEmpty &&
                    _accountNumberController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty) {
                  // ... (Similar confirmation dialog as SendMoneyScreen) ...
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: Text(
                          'Pay ${_amountController.text} to ${_billTypeController.text} for account ${_accountNumberController.text}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Simulate a successful transaction.
                            Navigator.pop(context); // Close dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Bill Paid successfully!')),
                            );
                            // Clear the fields
                            _billTypeController.clear();
                            _accountNumberController.clear();
                            _amountController.clear();
                            setState(() {
                              _aiRecommendation = null;
                            });
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields.')),
                  );
                }
              },
              child: const Text('Pay Bill'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAiRecommendations() async {
    if (_billTypeController.text.isNotEmpty) {
      setState(() {
        _aiRecommendation = null;
      });
      final recommendation =
          await _aiService.getBillPaymentAssistance(_billTypeController.text);
      setState(() {
        _aiRecommendation = recommendation;
      });
    } else {
      setState(() {
        _aiRecommendation = null;
      });
    }
  }

  Widget _buildAiRecommendationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.orange),
                SizedBox(width: 8),
                Text('AI Suggestions',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(_aiRecommendation!),
          ],
        ),
      ),
    );
  }
}
