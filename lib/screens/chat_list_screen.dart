import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/floating_search_bar.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. BARRA DE PESQUISA PADRONIZADA
              FloatingSearchBar(
                isEditable: true,
                margin: EdgeInsets.zero,
                hintText: 'Para onde vamos?',
                onChanged: (value) {
                  // Lógica de filtro de conversas aqui
                },
              ),
              const SizedBox(height: 24),

              // 2. TÍTULO SEÇÃO
              const Text(
                'Mensagens ativas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // 3. CARD DE CONVERSA
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF4A6DA7),
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  title: const Text(
                    'Empresa_tal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Text(
                    '15/04/2026',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatDetailScreen(userName: 'Empresa_tal'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // BARRA DE NAVEGAÇÃO INFERIOR
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}