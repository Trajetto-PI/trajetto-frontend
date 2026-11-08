import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/route_model.dart';

class RoutingService {
  static const String _baseUrl = 'https://router.project-osrm.org/route/v1/driving';

  static Future<RouteData?> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    // Formata explicitamente garantindo ponto (.) decimal e 6 casas decimais
    final String startLon = start.longitude.toStringAsFixed(6);
    final String startLat = start.latitude.toStringAsFixed(6);
    final String endLon = end.longitude.toStringAsFixed(6);
    final String endLat = end.latitude.toStringAsFixed(6);

    // OSRM: longitude,latitude;longitude,latitude
    final String coordinates = '$startLon,$startLat;$endLon,$endLat';
    final Uri url = Uri.parse(
      '$_baseUrl/$coordinates?overview=full&geometries=geojson&steps=true',
    );

    debugPrint('>>> [RoutingService] URL gerada: $url');

    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'TrajettoApp/1.0 (contato@trajetto.com)',
        },
      ).timeout(const Duration(seconds: 10));

      debugPrint('>>> [RoutingService] Status Code: ${response.statusCode}');
      debugPrint('>>> [RoutingService] Resposta: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['code'] != 'Ok') {
          debugPrint('>>> [RoutingService] Retorno diferente de Ok: ${data['code']}');
          return null;
        }

        final routes = data['routes'] as List<dynamic>?;
        if (routes == null || routes.isEmpty) {
          debugPrint('>>> [RoutingService] Lista de rotas vazia.');
          return null;
        }

        final route = routes[0];
        final geometry = route['geometry']['coordinates'] as List<dynamic>;

        // Converte par [lon, lat] para LatLng(lat, lon)
        final List<LatLng> polylinePoints = geometry.map((coord) {
          return LatLng(
            (coord[1] as num).toDouble(),
            (coord[0] as num).toDouble(),
          );
        }).toList();

        final double distanceKm = ((route['distance'] as num).toDouble()) / 1000.0;
        final int durationMin = (((route['duration'] as num).toDouble()) / 60.0).round();

        final List<RouteStep> steps = [];
        final legs = route['legs'] as List<dynamic>;
        if (legs.isNotEmpty) {
          final rawSteps = legs[0]['steps'] as List<dynamic>;
          for (var stepJson in rawSteps) {
            steps.add(RouteStep.fromJson(stepJson));
          }
        }

        debugPrint('>>> [RoutingService] Rota calculada com sucesso (${polylinePoints.length} pontos).');

        return RouteData(
          polylinePoints: polylinePoints,
          totalDistanceKm: distanceKm,
          totalDurationMin: durationMin,
          steps: steps,
        );
      } else {
        debugPrint('>>> [RoutingService] Falha HTTP ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('>>> [RoutingService] Exceção: $e');
      debugPrint('>>> [RoutingService] StackTrace: $stackTrace');
      return null;
    }
  }
}