import 'dart:async';
import 'package:flutter/material.dart';
import '../models/place_suggestion.dart';
import '../services/geocoding_service.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PlaceSuggestion> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Espera 500ms após o utilizador parar de digitar para evitar requisições em excesso
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.trim().isEmpty) {
        setState(() {
          _suggestions = [];
          _isLoading = false;
        });
        return;
      }

      setState(() => _isLoading = true);

      final results = await GeocodingService.searchPlaces(query);

      if (!mounted) return;
      setState(() {
        _suggestions = results;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Para onde vamos?',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                setState(() => _suggestions = []);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          if (_isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C8EEF)),
            ),
          Expanded(
            child: _suggestions.isEmpty && _searchController.text.isNotEmpty && !_isLoading
                ? const Center(
              child: Text(
                'Nenhum local encontrado.',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.separated(
              itemCount: _suggestions.length,
              separatorBuilder: (_, _) => const Divider(height: 1, indent: 64),
              itemBuilder: (context, index) {
                final item = _suggestions[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF1F3F4),
                    child: Icon(Icons.location_on, color: Color(0xFF1A73E8), size: 20),
                  ),
                  title: Text(
                    item.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    // Retorna o local selecionado de volta para o mapa
                    Navigator.pop(context, item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}