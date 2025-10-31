import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(const DiagnosticoApp());
}

class DiagnosticoApp extends StatelessWidget {
  const DiagnosticoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diagnóstico Técnico',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 5, 58, 101)),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
