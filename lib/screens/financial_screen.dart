import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class FinancialScreen extends StatelessWidget {
  const FinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C8EEF).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.attach_money_rounded,
                    size: 64,
                    color: Color(0xFF6C8EEF),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Financeiro em desenvolvimento',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Estamos preparando esta funcionalidade para você gerenciar seus ganhos e pagamentos. Disponível em breve!\n\n— Equipe Trajetto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Ajuste o currentIndex abaixo para o mesmo índice que esse ícone ocupa na sua CustomBottomNavBar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}