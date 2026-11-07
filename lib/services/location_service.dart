import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  /// Obtém a localização atual do usuário após validar serviços e permissões.
  static Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Testa se o GPS do aparelho está ativado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('O serviço de localização (GPS) está desativado no aparelho.');
    }

    // 2. Checa as permissões do aplicativo
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('A permissão de localização foi recusada pelo usuário.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'A permissão de localização foi negada permanentemente. Habilite nas configurações do aparelho.',
      );
    }

    // 3. Captura a coordenada com alta precisão
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return LatLng(position.latitude, position.longitude);
  }
}