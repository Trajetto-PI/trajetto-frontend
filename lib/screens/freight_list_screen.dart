import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/floating_search_bar.dart';
import 'freight_detail_screen.dart';

class FreightListScreen extends StatefulWidget {
  const FreightListScreen({super.key});

  @override
  State<FreightListScreen> createState() => _FreightListScreenState();
}

class _FreightListScreenState extends State<FreightListScreen> {

  final List<Map<String, String>> freights = [
  {
  'origin': 'Recife',
  'destination': 'Caruaru',
  'type': 'Carga Móveis (800kg)',
  'price': 'R\$ 4,00/km',
  'status': 'Disponível',
  'statusColor': 'green'
  },
  {
  'origin': 'Recife',
  'destination': 'Garanhuns',
  'type': 'Carga Móveis (800kg)',
  'price': 'R\$ 4,00/km',
  'status': 'Em negociação',
  'statusColor': 'amber'
  },
  {
  'origin': 'Recife',
  'destination': 'Caruaru',
  'type': 'Carga Móveis (800kg)',
  'price': 'R\$ 4,00/km',
  'status': 'Em negociação',
  'statusColor': 'amber'
  },
  {
  'origin': 'Recife',
  'destination': 'Gravatá',
  'type': 'Carga Móveis (800kg)',
  'price': 'R\$ 4,00/km',
  'status': 'Disponível',
  'statusColor': 'green'
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingSearchBar(
                isEditable: true,
                margin: EdgeInsets.zero,
                hintText: 'Para onde vamos?',
                onChanged: (value) {
                  // Lógica de filtro de fretes aqui
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Fretes ativos',
                style: TextStyle(fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: freights.length,
                  itemBuilder: (context, index) {
                    final item = freights[index];
                    final isGreen = item['statusColor'] == 'green';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FreightDetailScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 95,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(
                                    color: Color(0xFFE0E0E0))),
                              ),
                              child: const Icon(
                                Icons.archive_outlined,
                                size: 40,
                                color: Colors.black87,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item['origin']} ➔ ${item['destination']}',
                                      style: const TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Carga: Móveis (800kg)',
                                      style: const TextStyle(fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Valor: ${item['price']!}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['status']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isGreen ? Colors.green : Colors
                                            .amber.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}