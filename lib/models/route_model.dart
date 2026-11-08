import 'package:latlong2/latlong.dart';

class RouteStep {
  final String instruction;
  final double distance; // em metros
  final String modifier;  // right, left, straight, etc.
  final String type;      // turn, arrive, depart, etc.

  RouteStep({
    required this.instruction,
    required this.distance,
    required this.modifier,
    required this.type,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] ?? {};
    final streetName = json['name'] ?? '';
    final type = maneuver['type'] ?? '';
    final modifier = maneuver['modifier'] ?? '';
    final distance = (json['distance'] as num?)?.toDouble() ?? 0.0;

    String instruction = _formatInstruction(type, modifier, streetName);

    return RouteStep(
      instruction: instruction,
      distance: distance,
      modifier: modifier,
      type: type,
    );
  }

  static String _formatInstruction(String type, String modifier, String street) {
    String road = street.isNotEmpty ? ' na $street' : '';

    if (type == 'depart') return 'Inicie o trajeto$road';
    if (type == 'arrive') return 'Chegou ao seu destino';

    switch (modifier) {
      case 'left':
        return 'Vire à esquerda$road';
      case 'right':
        return 'Vire à direita$road';
      case 'sharp left':
        return 'Curva acentuada à esquerda$road';
      case 'sharp right':
        return 'Curva acentuada à direita$road';
      case 'slight left':
        return 'Mantenha-se à esquerda$road';
      case 'slight right':
        return 'Mantenha-se à direita$road';
      case 'straight':
        return 'Siga em frente$road';
      case 'uturn':
        return 'Faça inversão de marcha$road';
      default:
        return 'Siga em frente$road';
    }
  }
}

class RouteData {
  final List<LatLng> polylinePoints;
  final double totalDistanceKm;
  final int totalDurationMin;
  final List<RouteStep> steps;

  RouteData({
    required this.polylinePoints,
    required this.totalDistanceKm,
    required this.totalDurationMin,
    required this.steps,
  });
}