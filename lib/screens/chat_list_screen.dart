import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';
import 'profile_screen.dart';
import '../main.dart';
import 'freight_list_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

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
              // 1. BARRA DE PESQUISA
              TextField(
                decoration: InputDecoration(
                  hintText: 'Para onde vamos?',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                  ),
                ),
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: 1, // Mantém o ícone do Chat destacado (índice 1)
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF6C8EEF),
          unselectedItemColor: Colors.black87,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
        onTap: (i) {
            if (i == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FreightListScreen()),
              );
            }
            if (i == 1) {
              // Já estamos na tela de chat
            }
            // O ícone de localização/fretes (índice 3) vai levar de volta para a lista de fretes:
            if (i == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FreightListScreen()),
              );
            }
            if (i == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.history, size: 30), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded, size: 28), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined, size: 30), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 30), label: ''),
          ],
        ),
      ),
    );
  }
}
