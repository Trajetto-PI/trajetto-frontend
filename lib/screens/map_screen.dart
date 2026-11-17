import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place_suggestion.dart';
import '../models/route_model.dart';
import 'place_search_screen.dart';
import '../services/location_service.dart';
import '../services/routing_service.dart';
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
  PlaceSuggestion? _selectedPlace;
  RouteData? _routeData;

  bool _isLoading = true;
  bool _isCalculatingRoute = false;
  bool _isNavigating = false; // Controla se o motorista iniciou a viagem

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

  Future<void> _calculateRoute(LatLng destination) async {
    debugPrint('>>> [MapScreen] BOTAO CLICADO!');
    debugPrint('>>> [MapScreen] POSICAO ATUAL: $_currentPosition');
    debugPrint('>>> [MapScreen] DESTINO: $destination');

    if (_currentPosition == null) {
      debugPrint('>>> [MapScreen] AVISO: Posicao atual nula, aguardando GPS.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aguardando sinal de GPS do dispositivo...'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isCalculatingRoute = true);

    final route = await RoutingService.getRoute(
      start: _currentPosition!,
      end: destination,
    );

    debugPrint('>>> [MapScreen] RETORNO DA ROTA: $route');

    if (!mounted) return;

    setState(() {
      _routeData = route;
      _isCalculatingRoute = false;
    });

    if (route == null || route.polylinePoints.isEmpty) {
      debugPrint('>>> [MapScreen] FALHA: Rota vazia ou nula.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível calcular a rota para este endereço.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    debugPrint('>>> [MapScreen] SUCESSO: Desenhando linha com ${route.polylinePoints.length} pontos.');

    final bounds = LatLngBounds.fromPoints([
      _currentPosition!,
      destination,
      ...route.polylinePoints,
    ]);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.only(top: 80, bottom: 240, left: 40, right: 40),
      ),
    );
  }

  void _clearSelection() {
    setState(() {
      _selectedPlace = null;
      _routeData = null;
      _isNavigating = false;
    });
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 15.5);
    }
  }

  IconData _getManeuverIcon(String modifier) {
    switch (modifier) {
      case 'left':
      case 'sharp left':
        return Icons.turn_left;
      case 'right':
      case 'sharp right':
        return Icons.turn_right;
      case 'slight left':
        return Icons.turn_slight_left;
      case 'slight right':
        return Icons.turn_slight_right;
      case 'uturn':
        return Icons.u_turn_left;
      default:
        return Icons.straight;
    }
  }

  void _showAllStepsModal() {
    if (_routeData == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Itinerário Completo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: _routeData!.steps.length,
                  separatorBuilder: (_, _) => const Divider(height: 1, indent: 64),
                  itemBuilder: (context, index) {
                    final step = _routeData!.steps[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE8F0FE),
                        child: Icon(
                          _getManeuverIcon(step.modifier),
                          color: const Color(0xFF1A73E8),
                        ),
                      ),
                      title: Text(
                        step.instruction,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${step.distance.round()} m',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. MAPA DE FUNDO
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
                if (_routeData != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routeData!.polylinePoints,
                        strokeWidth: 5.5,
                        color: const Color(0xFF1A73E8),
                      ),
                    ],
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
                          child: Icon(Icons.my_location, color: Color(0xFF1A73E8), size: 26),
                        ),
                      ),
                    ),
                    if (_selectedPlace != null)
                      Marker(
                        point: _selectedPlace!.point,
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.location_on, color: Colors.redAccent, size: 40),
                      ),
                  ],
                ),
              ],
            )
          else if (!_isLoading)
            const Center(
              child: Text('Não foi possível obter a localização.', style: TextStyle(color: Colors.grey)),
            ),

          // 2. LOADING
          if (_isLoading || _isCalculatingRoute)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(strokeWidth: 3),
                    const SizedBox(height: 12),
                    Text(
                      _isCalculatingRoute ? 'Traçando rota...' : 'Carregando mapa...',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

          // 3. TOPO: MODO NAVEGAÇÃO OU BARRA DE PESQUISA NORMAL
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: _isNavigating && _routeData != null && _routeData!.steps.isNotEmpty
                  ? Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F9D58),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      _getManeuverIcon(_routeData!.steps.first.modifier),
                      color: Colors.white,
                      size: 34,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Em ${_routeData!.steps.first.distance.round()} m',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _routeData!.steps.first.instruction,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() => _isNavigating = false);
                      },
                    ),
                  ],
                ),
              )
                  : FloatingSearchBar(
                margin: EdgeInsets.zero,
                onTap: () async {
                  final PlaceSuggestion? place = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlaceSearchScreen()),
                  );

                  if (place != null && mounted) {
                    setState(() {
                      _selectedPlace = place;
                      _routeData = null;
                      _isNavigating = false;
                    });
                    _mapController.move(place.point, 16.0);
                  }
                },
              ),
            ),
          ),

          // 4. PAINEL INFERIOR DINÂMICO
          // CENÁRIO A: Local pesquisado mas rota ainda não calculada
          if (_selectedPlace != null && _routeData == null && !_isCalculatingRoute)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.redAccent, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedPlace!.displayName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: _clearSelection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _calculateRoute(_selectedPlace!.point),
                        icon: const Icon(Icons.directions),
                        label: const Text('Calcular Rota'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A73E8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // CENÁRIO B: Rota calculada (Resumo ou em navegação)
          if (_routeData != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_routeData!.totalDurationMin} min',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F9D58),
                              ),
                            ),
                            Text(
                              '${_routeData!.totalDistanceKm.toStringAsFixed(1)} km',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: _showAllStepsModal,
                              icon: const Icon(Icons.format_list_bulleted, size: 18),
                              label: const Text('Itinerário'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: _clearSelection,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _isNavigating = !_isNavigating);
                          if (_isNavigating && _currentPosition != null) {
                            _mapController.move(_currentPosition!, 17.5);
                          }
                        },
                        icon: Icon(_isNavigating ? Icons.stop : Icons.navigation),
                        label: Text(_isNavigating ? 'Encerrar Deslocamento' : 'Seguir Trajeto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isNavigating ? Colors.redAccent : const Color(0xFF0F9D58),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 5. BOTÃO RECENTRALIZAR (Apenas quando nenhum local estiver selecionado)
          if (_selectedPlace == null)
            Positioned(
              right: 20,
              bottom: 30,
              child: FloatingActionButton(
                mini: true,
                elevation: 2,
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                onPressed: () {
                  if (_currentPosition != null) {
                    _mapController.move(_currentPosition!, 15.5);
                  } else {
                    _fetchUserLocation();
                  }
                },
                child: const Icon(Icons.my_location_rounded, color: Color(0xFF3C4043), size: 22),
              ),
            ),
        ],
      ),

      // 6. BARRA DE NAVEGAÇÃO COMPARTILHADA
      bottomNavigationBar: _isNavigating ? null : const CustomBottomNavBar(currentIndex: 2),
    );
  }
}