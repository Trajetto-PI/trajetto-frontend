import 'package:flutter/material.dart';
import 'freight_list_screen.dart';
import '../main.dart';

class RegisterCompanyScreen extends StatelessWidget {
  const RegisterCompanyScreen({super.key});

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
                'Cadastre-se',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6C8EEF)),
              ),
              const SizedBox(height: 20),
              buildInputField('Nome'),
              buildInputField('CNPJ'),
              buildInputField('E-mail'),
              buildInputField('Telefone'),
              buildInputField('Endereço'),
              buildInputField('Cidade'),
              buildInputField('Estado'),
              buildInputField('CEP'),
              buildInputField('Senha', isPassword: true),
              buildInputField('Confirmar Senha', isPassword: true),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  const Text('Aceito as políticas de privacidade', style: TextStyle(fontSize: 13)),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
