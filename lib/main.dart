import 'package:flutter/material.dart';

void main() {
  runApp(const TrajettoApp());
}

class TrajettoApp extends StatelessWidget {
  const TrajettoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trajetto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C8EEF),
          primary: const Color(0xFF6C8EEF),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Estilo padrão dos botões
final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF6C8EEF),
  foregroundColor: Colors.white,
  elevation: 0,
  padding: const EdgeInsets.symmetric(vertical: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);

// Estilo dos campos de texto (Input)
InputDecoration customInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    filled: true,
    fillColor: const Color(0xFFF8F9FA),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
  );
}

// Widget genérico para campos de formulário
Widget buildInputField(String label, {bool isPassword = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 6),
        TextField(
          obscureText: isPassword,
          style: const TextStyle(fontSize: 15),
          decoration: customInputDecoration('Digite aqui'),
        ),
      ],
    ),
  );
}

// ==================== 1. TELA BEM-VINDO ====================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Bem-Vindo\nao Trajetto',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C8EEF),
                  height: 1.2,
                ),
              ),
              const Spacer(),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.navigation, size: 120, color: Color(0xFF6C8EEF)),
                ),
              ),
              const Spacer(),
              const Text(
                'Direcione sua rota,\nmaximize seus lucros.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Conectando você ao melhor caminho, com rapidez e segurança.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: primaryButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text('Login', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: primaryButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                  );
                },
                child: const Text('Cadastre-se', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const FreightListScreen()),
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
                label: const Text(
                  'Continuar com Google',
                  style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== 2. TELA ESCOLHA (MOTORISTA / EMPRESA) ====================
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
              const Text(
                'Escolha',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C8EEF),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  children: [
                    _buildOptionCard(
                      context,
                      title: 'Motorista',
                      imagePath: 'assets/motoristas.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterDriverScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionCard(
                      context,
                      title: 'Empresas',
                      imagePath: 'assets/empresas.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterCompanyScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, {required String title, required String imagePath, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 80, color: Color(0xFF6C8EEF));
                },
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== 3. CADASTRO MOTORISTA ====================
class RegisterDriverScreen extends StatelessWidget {
  const RegisterDriverScreen({super.key});

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
              buildInputField('CPF'),
              buildInputField('E-mail'),
              buildInputField('Telefone'),
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

// ==================== 4. CADASTRO EMPRESA ====================
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

// ==================== 5. TELA DE LOGIN ====================
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

// ==================== 6. LISTA DE FRETES ====================
class FreightListScreen extends StatefulWidget {
  const FreightListScreen({super.key});

  @override
  State<FreightListScreen> createState() => _FreightListScreenState();
}

class _FreightListScreenState extends State<FreightListScreen> {
  int _selectedIndex = 3;

  final List<Map<String, String>> freights = [
    {'origin': 'Recife', 'destination': 'Caruaru', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Disponível', 'statusColor': 'green'},
    {'origin': 'Recife', 'destination': 'Garanhuns', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Em negociação', 'statusColor': 'amber'},
    {'origin': 'Recife', 'destination': 'Caruaru', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Em negociação', 'statusColor': 'amber'},
    {'origin': 'Recife', 'destination': 'Gravatá', 'type': 'Carga Móveis (800kg)', 'price': 'R\$ 4,00/km', 'status': 'Disponível', 'statusColor': 'green'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Para onde vamos?',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    prefixIcon: Icon(Icons.search, color: Colors.black54, size: 26),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Fretes ativos',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: freights.length,
                  itemBuilder: (context, index) {
                    final item = freights[index];
                    final isGreen = item['statusColor'] == 'green';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const FreightDetailScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 95,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFE0E0E0))),
                              ),
                              child: const Icon(
                                Icons.archive_outlined,
                                size: 40,
                                color: Colors.black87,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item['origin']} ➔ ${item['destination']}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Carga: Móveis (800kg)',
                                      style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Valor: ${item['price']!}',
                                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['status']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isGreen ? Colors.green : Colors.amber.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6C8EEF),
        unselectedItemColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded, size: 28), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 30), label: ''),
        ],
      ),
    );
  }
}

// ==================== 7. DETALHES COMPLETOS DO FRETE ====================
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

// ==================== 8. RESUMO DO FRETE ====================
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

// ==================== 9. MODAL DE SUCESSO ====================
class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // Clique em qualquer lugar do modal para fechar e voltar
          Navigator.pop(context); // Fecha o modal
          Navigator.pop(context); // Volta da tela de confirmação
          Navigator.pop(context); // Volta da tela de detalhes
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sucesso',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Corrida aceita com sucesso, fique atento as proximas informações',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50), // Verde vibrante preenchido igual da imagem
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
