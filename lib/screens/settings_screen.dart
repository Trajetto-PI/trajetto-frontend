import 'package:flutter/material.dart';
import 'settings_screen.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Configurações',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Opções Principais
            _buildSettingTile(
              title: 'Documentos',
              onTap: () {},
            ),
            _buildSettingTile(
              title: 'Histórico de Fretes',
              onTap: () {},
            ),
            _buildSettingTile(
              title: 'Histórico Financeiro',
              onTap: () {},
            ),
            _buildSettingTile(
              title: 'Notificações',
              onTap: () {},
            ),

            const Spacer(),

            // Opções Inferiores
            _buildSettingTile(
              title: 'Tema',
              subtitle: 'Claro',
              onTap: () {},
            ),
            _buildSettingTile(
              title: 'Idioma',
              subtitle: 'Português',
              onTap: () {},
            ),
            _buildSettingTile(
              title: 'Sair',
              titleColor: Colors.redAccent,
              onTap: () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    String? subtitle,
    Color titleColor = Colors.black87,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                if (subtitle != null) ...[
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
