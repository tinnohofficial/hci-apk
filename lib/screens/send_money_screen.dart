// lib/screens/send_money_screen.dart
import 'package:flutter/material.dart';
import 'package:hci/services/ai_service.dart'; // Import AIService

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  String? _aiRecommendation;
  final _aiService = AIService(); // Create an instance of AIService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Recipient Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (_) => _getAiRecommendations(), // Call on changes
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) =>
                  _getAiRecommendations(), // Also call on amount changes!
            ),
            if (_aiRecommendation != null) ...[
              const SizedBox(height: 16),
              Card(
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
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement send money logic (Placeholder for now)
                if (_phoneController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty) {
                  // In a real app, you'd send the data to your backend
                  // for processing and confirmation.
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: Text(
                          'Send ${_amountController.text} to ${_phoneController.text}?'),
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
                                  content: Text('Money sent successfully!')),
                            );
                            // Clear the fields
                            _phoneController.clear();
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
                    const SnackBar(
                        content: Text('Please enter phone number and amount.')),
                  );
                }
              },
              child: const Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAiRecommendations() async {
    if (_phoneController.text.isNotEmpty) {
      // Only call if the phone number is not empty
      setState(() {
        _aiRecommendation =
            null; // Clear previous recommendations while loading
      });
      final recommendation =
          await _aiService.getSendMoneyRecommendations(_phoneController.text);
      setState(() {
        _aiRecommendation = recommendation;
      });
    } else {
      setState(() {
        _aiRecommendation = null; // Clear recommendations if field is empty
      });
    }
  }
}
