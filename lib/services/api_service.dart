import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/summary_response.dart';

class ApiService {
  static const String baseUrl = 'http://35.216.42.202:8080/api';

  Future<SummaryResponse> getSummary(double lat, double lon) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/summary'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'lat': lat,
          'lon': lon,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SummaryResponse.fromJson(jsonData);
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API 요청 중 오류 발생: $e');
    }
  }
}
