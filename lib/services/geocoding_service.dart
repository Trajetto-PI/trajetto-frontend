import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place_suggestion.dart';

class GeocodingService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  /// Busca endereços a partir de um texto digitado
  static Future<List<PlaceSuggestion>> searchPlaces(String query) async {
    if (query.trim().isEmpty) return [];

    final Uri url = Uri.parse(
      '$_baseUrl?q=${Uri.encodeComponent(query)}&format=json&addressdetails=1&limit=5&countrycodes=br',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          // O Nominatim exige um User-Agent identificando a aplicação
          'User-Agent': 'TrajettoApp/1.0 (contato@trajetto.com)',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => PlaceSuggestion.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}