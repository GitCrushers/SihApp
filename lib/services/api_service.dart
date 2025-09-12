import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_data.dart';

class ApiService {
  static const String baseUrl =
      'https://sihwebsite-a2hp.onrender.com/api/v2/data';

  static Future<DashboardData> fetchDashboardData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      // we take the first item in the 'data' array
      final firstItem = (jsonMap['data'] as List).first;
      return DashboardData.fromJson(firstItem);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
