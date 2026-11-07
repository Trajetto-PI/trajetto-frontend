import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    setState(() => _isLoading = true);

    try {
      final LatLng pos = await LocationService.getCurrentLocation();
      if (!mounted) return;
      setState(() {
        _currentPosition = pos;
        _isLoading = false;
      });
      _mapController.move(pos, 15.5);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. MAPA DE FUNDO (ocupa a tela inteira)
          if (_currentPosition != null)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition!,
                initialZoom: 15.5,
                minZoom: 3.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.maps_app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withValues(alpha: 0.2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.my_location,
                            color: Color(0xFF1A73E8),
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          else if (!_isLoading)
            const Center(
              child: Text(
                'Não foi possível obter a localização.',
                style: TextStyle(color: Colors.grey),
              ),
            ),

          // 2. LOADING CENTRAL
          if (_isLoading)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(strokeWidth: 3),
                    SizedBox(height: 12),
                    Text(
                      'Carregando mapa...',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

          // 3. BARRA DE PESQUISA FLUTUANTE (TOPO)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingSearchBar(
                onTap: () {
                  // Aqui chamaremos a tela/modal de pesquisa na próxima etapa
                },
              ),
            ),
          ),

          // 4. BOTÃO FLUTUANTE DE RECENTRALIZAR
          Positioned(
            right: 20,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                onPressed: () {
                  if (_currentPosition != null) {
                    _mapController.move(_currentPosition!, 15.5);
                  } else {
                    _fetchUserLocation();
                  }
                },
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Color(0xFF3C4043),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      // 5. BARRA DE NAVEGAÇÃO COMPARTILHADA (Índice 2 = Mapa/Home)
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}