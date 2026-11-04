import 'package:flutter/material.dart';
import '../main.dart';
import 'chat_list_screen.dart';
import 'settings_screen.dart';
import 'freight_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
       actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.black87),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
    ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Card Principal do Perfil
            _buildMainProfileCard(),
            const SizedBox(height: 16),

            // 2. Métricas (Corridas realizadas e Avaliações positivas)
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.local_shipping_outlined,
                    value: '234',
                    label: 'Corridas realizadas',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.thumb_up_alt_outlined,
                    value: '96%',
                    label: 'Avaliações positivas',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Título de Distribuição das Notas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Distribuição das notas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'últimos 30 dias',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRatingDistributionCard(),
            const SizedBox(height: 20),

            // 4. Seção de Comentários
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comentários',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text(
                        'Ver tudo',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      Icon(Icons.chevron_right, size: 18, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildCommentCard(
              name: 'Cleyton Alves',
              comment: '"Entrega rápida e carga muito bem cuidada."',
              route: 'Recife ➔ Caruaru',
            ),
            const SizedBox(height: 12),
            _buildCommentCard(
              name: 'Cleyton Alves',
              comment: '"Entrega rápida e carga muito bem cuidada."',
              route: '',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Widget do Card Principal
  Widget _buildMainProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF4A68D1),
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cleyton Alves',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Motorista verificado · há 3 anos',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 22),
                  SizedBox(width: 4),
                  Text(
                    '4,8',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' / 5,0',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '234',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Avaliações',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget dos Cards de Métricas
  Widget _buildMetricCard({required IconData icon, required String value, required String label}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Widget de Distribuição de Notas
  Widget _buildRatingDistributionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildRatingBar(5, 0.75),
          _buildRatingBar(4, 0.25),
          _buildRatingBar(3, 0.15),
          _buildRatingBar(2, 0.08),
          _buildRatingBar(1, 0.03),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int star, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text('$star', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5C7CFA)),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget de Comentários
  Widget _buildCommentCard({required String name, required String comment, String route = ''}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF4A68D1),
                child: Icon(Icons.person, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star, color: Colors.amber, size: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(comment, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          if (route.isNotEmpty) ...[
            const Divider(height: 20),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Text(route, style: const TextStyle(fontSize: 12, color: Colors.black87)),
              ],
            ),
          ]
        ],
      ),
    );
  }

  // Barra de Navegação Inferior
  // Barra de Navegação Inferior
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF5C7CFA),
     unselectedItemColor: Colors.black87,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      
      // === ADICIONA ESTE BLOCO AQUI (linha 1206): ===
   onTap: (index) {
        // Índice 0: Histórico
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FreightListScreen()),
          );
        }
        // Índice 1: Chat
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ChatListScreen()),
          );
        }
        // Índice 3: Localização / Fretes
        if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FreightListScreen()),
          );
        }
        // Índice 4: Perfil (já estamos aqui)
      },
      // ===============================================

     items: const [
  BottomNavigationBarItem(
    icon: Icon(Icons.history, size: 30), 
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.chat_bubble_outline_rounded, size: 28), 
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined, size: 30), 
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.location_on_outlined, size: 30), 
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded, size: 30), 
    label: '',
  ),
],
    );
  }
}
