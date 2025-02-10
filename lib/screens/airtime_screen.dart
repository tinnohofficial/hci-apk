// lib/screens/airtime_screen.dart
import 'package:flutter/material.dart';
import 'package:hci/services/ai_service.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final _phoneController = TextEditingController();
  String? _selectedProvider;
  String? _selectedBundle;
  String? _aiRecommendation;
  final _aiService = AIService();

  final _providers = ['Vodacom', 'Tigo', 'Airtel', 'Halotel'];
  final _bundles = {
    'Internet': ['1GB - 1000/=', '2GB - 2000/=', '5GB - 5000/='],
    'Voice': ['Daily', 'Weekly', 'Monthly'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Airtime & Bundles')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (_) => _getAiRecommendations(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Provider',
                prefixIcon: Icon(Icons.business),
              ),
              value: _selectedProvider,
              items: _providers.map((provider) {
                return DropdownMenuItem(
                  value: provider,
                  child: Text(provider),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProvider = value;
                });
                _getAiRecommendations(); // Get recommendations when provider changes
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showBundleOptions('Internet');
                    },
                    child: const Text('Internet Bundles'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showBundleOptions('Voice');
                    },
                    child: const Text('Voice Bundles'),
                  ),
                ),
              ],
            ),
            if (_aiRecommendation != null) ...[
              const SizedBox(height: 16),
              _buildAiRecommendationCard(),
            ],
          ],
        ),
      ),
    );
  }

  void _showBundleOptions(String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _bundles[type]?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_bundles[type]![index]),
              onTap: () {
                setState(() {
                  _selectedBundle = _bundles[type]![index];
                });
                Navigator.pop(context);

                //Confirmation after choice
                if (_selectedBundle != null) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text("Confirm Purchase"),
                            content: Text(
                                "Buy $_selectedBundle for ${_phoneController.text}?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "$_selectedBundle Purchased")));

                                  //Clear
                                  _phoneController.clear();
                                  setState(() {
                                    _selectedProvider = null;
                                    _selectedBundle = null;
                                    _aiRecommendation = null;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("okay"),
                                ),
                              ),
                            ],
                          ));
                }
              },
            );
          },
        );
      },
    );
  }

  Future<void> _getAiRecommendations() async {
    // Use phone number and provider for a more specific recommendation.
    if (_phoneController.text.isNotEmpty && _selectedProvider != null) {
      setState(() {
        _aiRecommendation = null;
      });
      //  Pass usage information.  In a real app, you'd get this from
      //  user data, not just concatenate the phone and provider.
      final usageInfo =
          'Phone: ${_phoneController.text}, Provider: $_selectedProvider';
      final recommendation =
          await _aiService.getAirtimeBundleRecommendations(usageInfo);
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
                Text('Smart Bundle Recommendations',
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
