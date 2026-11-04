import 'package:flutter/material.dart';
import 'freight_list_screen.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF6C8EEF)),
              ),
              const SizedBox(height: 30),
              const Text('Nome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              TextField(
                style: const TextStyle(fontSize: 15),
                decoration: customInputDecoration('Digite aqui'),
              ),
              const SizedBox(height: 16),
              const Text('Senha', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              TextField(
                obscureText: true,
                style: const TextStyle(fontSize: 15),
                decoration: customInputDecoration('Digite aqui'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Esqueci minha senha', style: TextStyle(color: Color(0xFF6C8EEF), fontSize: 13)),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: primaryButtonStyle,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const FreightListScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Entrar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('ou', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const FreightListScreen()),
                    (route) => false,
                  );
                },
                icon: Image.asset(
                  'assets/google.png',
                  height: 24,
                  width: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.g_mobiledata, size: 28, color: Colors.red);
                  },
                ),
                label: const Text('Continuar com Google', style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}