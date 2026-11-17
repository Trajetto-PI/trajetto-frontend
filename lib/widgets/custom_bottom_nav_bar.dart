import 'package:flutter/material.dart';
import '../screens/chat_list_screen.dart';
import '../screens/financial_screen.dart';
import '../screens/freight_list_screen.dart';
import '../screens/map_screen.dart';
import '../screens/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    // Se o usuário clicou no ícone da própria tela onde ele já está, não faz nada
    if (index == currentIndex) return;

    Widget nextScreen;

    switch (index) {
      case 0:
      // Financeiro (em desenvolvimento)
        nextScreen = const FinancialScreen();
        break;
      case 1:
      // Chat
        nextScreen = const ChatListScreen();
        break;
      case 2:
      // Início / Mapa
        nextScreen = const MapScreen();
        break;
      case 3:
      // Fretes
        nextScreen = const FreightListScreen();
        break;
      case 4:
      // Perfil
        nextScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6C8EEF),
        unselectedItemColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded, size: 26),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}