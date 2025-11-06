import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // gerado pelo flutterfire configure
import 'homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter está pronto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inicializa o Firebase
  );

  runApp(const DiagnosticoApp());
}

class DiagnosticoApp extends StatelessWidget {
  const DiagnosticoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diagnóstico Técnico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 5, 58, 101),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
