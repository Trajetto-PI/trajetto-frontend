import 'package:flutter/material.dart';
import 'success_dialog.dart';
import '../main.dart';

class FreightConfirmationScreen extends StatelessWidget {
  const FreightConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Empresa-tal', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const Text('24/02/2025 · 10:23:04', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 28),
              const Text('Carga', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 6),
              const Text('Tipo: Móveis\nPeso: 800kg\nVolume: Médio\nQuantidade: 10', style: TextStyle(fontSize: 15, height: 1.5)),
              const SizedBox(height: 24),
              const Text('Pagamento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 6),
              const Text('Valor: R\$ 4,00/km\nForma: A combinar\nPedágio: Incluso', style: TextStyle(fontSize: 15, height: 1.5)),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: primaryButtonStyle,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const SuccessDialog(),
                    );
                  },
                  child: const Text('Confirmar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: Color(0xFF6C8EEF)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Negociar Valor', style: TextStyle(color: Color(0xFF6C8EEF), fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
