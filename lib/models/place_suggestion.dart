import 'package:latlong2/latlong.dart';

class PlaceSuggestion {
  final String displayName;
  final LatLng point;

  PlaceSuggestion({
    required this.displayName,
    required this.point,
  });

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      displayName: json['display_name'] ?? '',
      point: LatLng(
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
    );
  }
}