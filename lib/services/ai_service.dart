// lib/services/ai_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash', //Or gemini-pro, see comments below
      apiKey:
          "AIzaSyCn590zL2B-71xN63SX_pe-fxMZpJhBeb8", // Replace with your actual key
      // apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
  }

  Future<String> getSendMoneyRecommendations(String phoneNumber) async {
    try {
      final prompt = '''
      Extremely concise recommendations for sending money to $phoneNumber:
      - Amount: [Amount]
      - Recipient: [New/Frequent]
      - Warning: [Warning/None]
      - Limit: [Amount]
      
      Always provide a value for each field.  If no specific data, use defaults: Amount: 5000, Recipient: New, Warning: None, Limit: 100000.  Be VERY brief.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      // Fallback if response is null or empty.
      return response.text?.trim() ??
          'Amount: 5000\nRecipient: New\nWarning: None\nLimit: 100000';
    } catch (e) {
      // More specific error handling
      return 'Error: Check API key/network.';
    }
  }

  Future<String> getBillPaymentAssistance(String billType) async {
    try {
      final prompt = '''
      Extremely concise advice for $billType bill:
      - Amount: [Amount]
      - Time: [Date/ASAP]
      - Change: [Yes/No/Slight]
      - Tip: [Pay early/Auto-pay]
      
      Always provide a value. Defaults: Amount: 10000, Time: ASAP, Change: No, Tip: Auto-pay. Be VERY brief.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text?.trim() ??
          'Amount: 10000\nTime: ASAP\nChange: No\nTip: Auto-pay';
    } catch (e) {
      return 'Error: Check API key/network.';
    }
  }

  Future<String> getAirtimeBundleRecommendations(String usage) async {
    try {
      final prompt = '''
      Extremely concise airtime/bundle recommendation based on usage $usage:
      - Bundle: [Data/Voice/Combo]
      - Timing: [Now/Later]
      - Previous: [Better/Worse/Same]
      - Next Month: [More/Less/Same]

      Always provide a value. Defaults: Bundle: Data, Timing: Now, Previous: Same, Next Month: Same. Be VERY brief.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text?.trim() ??
          'Bundle: Data\nTiming: Now\nPrevious: Same\nNext Month: Same';
    } catch (e) {
      return 'Error: Check API key/network.';
    }
  }
}
