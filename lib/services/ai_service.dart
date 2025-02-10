// lib/services/ai_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http; // Import the http package
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  //  Use a constant for the base URL.  Make it configurable via .env
  final String _baseUrl =
      'https://endearing-courtesy-production.up.railway.app/v1';

  // No more Gemini initialization here.

  Future<String> getSendMoneyRecommendations(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/send_money'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['recommendation'] ??
            'Amount: 5000\nRecipient: New\nWarning: None\nLimit: 100000'; // Fallback
      } else {
        return 'Error: Server returned status code ${response.statusCode}';
      }
    } catch (e) {
      // More specific error handling, including network issues.
      return 'Error: Could not connect to the server. $e';
    }
  }

  Future<String> getBillPaymentAssistance(String billType) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/pay_bill'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'billType': billType}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['recommendation'] ??
            'Amount: 10000\nTime: ASAP\nChange: No\nTip: Auto-pay'; // Fallback
      } else {
        return 'Error: Server returned status code ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: Could not connect to the server. $e';
    }
  }

  Future<String> getAirtimeBundleRecommendations(String usage) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/airtime_bundle'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usage': usage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['recommendation'] ??
            'Bundle: Data\nTiming: Now\nPrevious: Same\nNext Month: Same'; // Fallback
      } else {
        return 'Error: Server returned status code ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: Could not connect to the server. $e';
    }
  }
}
