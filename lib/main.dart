import 'package:flutter/material.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/success_dialog.dart';
import 'screens/freight_confirmation_screen.dart';
import 'screens/freight_detail_screen.dart';
import 'screens/freight_list_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_company_screen.dart';
import 'screens/register_driver_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/welcome_screen.dart';


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

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF6C8EEF),
  foregroundColor: Colors.white,
  elevation: 0,
  padding: const EdgeInsets.symmetric(vertical: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);

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








