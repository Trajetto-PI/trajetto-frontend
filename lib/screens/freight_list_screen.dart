import 'package:flutter/material.dart';
import '../main.dart';
import 'chat_list_screen.dart';
import 'profile_screen.dart';
import 'freight_detail_screen.dart';

class FreightListScreen extends StatefulWidget {
  const FreightListScreen({super.key});

  @override
  State<FreightListScreen> createState() => _FreightListScreenState();
}

class _FreightListScreenState extends State<FreightListScreen> {
  int _selectedIndex = 3;

  final List<Map<String, String>> freights = [
    {'origin': 'Recife', 'destination': 'Caruaru', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Disponível', 'statusColor': 'green'},
    {'origin': 'Recife', 'destination': 'Garanhuns', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Em negociação', 'statusColor': 'amber'},
    {'origin': 'Recife', 'destination': 'Caruaru', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Em negociação', 'statusColor': 'amber'},
    {'origin': 'Recife', 'destination': 'Gravatá', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Disponível', 'statusColor': 'green'},
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Para onde vamos?',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    prefixIcon: Icon(Icons.search, color: Colors.black54, size: 26),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Fretes ativos',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
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
                            MaterialPageRoute(builder: (_) => const FreightDetailScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 95,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFE0E0E0))),
                              ),
                              child: const Icon(
                                Icons.archive_outlined,
                                size: 40,
                                color: Colors.black87,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item['origin']} ➔ ${item['destination']}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Carga: Móveis (800kg)',
                                      style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Valor: ${item['price']!}',
                                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['status']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isGreen ? Colors.green : Colors.amber.shade800,
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
     child: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (i) {
    setState(() => _selectedIndex = i);
   if (i == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatListScreen()),
      );
    }
  if (i == 4) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  },
    
  type: BottomNavigationBarType.fixed,
  selectedItemColor: const Color(0xFF6C8EEF),
  unselectedItemColor: Colors.black87,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  elevation: 0,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.history, size: 30), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded, size: 28), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined, size: 30), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 30), label: ''),
        ],
      ),
    );
  }
}
