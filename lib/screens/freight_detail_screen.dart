import 'package:flutter/material.dart';
import 'freight_confirmation_screen.dart';
import '../main.dart';

class FreightDetailScreen extends StatelessWidget {
  const FreightDetailScreen({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Empresa-tal', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const Text('24/02/2025 · 10:23:04', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 24),

              _buildSectionTitle('Rotas - Recife ➔ Caruaru'),
              _buildInfoText('Distância: ~130km'),
              const SizedBox(height: 12),
              _buildSectionTitle('Coleta - Recife • PE'),
              _buildInfoText('Rua Rua General Polidoro\nNúmero: 345\nComplemento: Apto 003'),
              _buildInfoText('Bairro: Boa Viagem\nCidade: Recife\nEstado: PE\nCEP: 50021-030\nPonto de referência: Próximo ao Shopping Recife'),

              const SizedBox(height: 20),
              _buildSectionTitle('Entrega - Caruaru • PE'),
              _buildInfoText('Rua Avenida Agamenon Magalhães\nNúmero: 615\nComplemento: Apto 002'),
              _buildInfoText('Bairro: Maurício de Nassau\nCidade: Caruaru\nEstado: PE\nCEP: 55010-020\nPonto de referência: Em frente ao Caruaru Shopping'),

              const SizedBox(height: 20),
              _buildSectionTitle('Carga'),
              _buildInfoText('Tipo: Móveis\nPeso: 800kg\nVolume: Médio\nQuantidade: 10'),
              _buildInfoText('Material: Camas, Mesas, Sofás\nCuidados: Carga frágil'),

              const SizedBox(height: 20),
              _buildSectionTitle('Pagamento'),
              _buildInfoText('Valor: R\$ 4,00/km\nForma: A combinar\nPedágio: Incluso\nNegociável: Sim'),

              const SizedBox(height: 20),
              _buildSectionTitle('Observações'),
              _buildInfoText('Necessário cuidado ao carregar e descarregar.\nPreferência por motoristas experientes.'),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: primaryButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FreightConfirmationScreen()),
                    );
                  },
                  child: const Text('Aceitar Frete', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
                  onPressed: () {},
                  child: const Text('Negociar Valor', style: TextStyle(color: Color(0xFF6C8EEF), fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4)),
    );
  }
}