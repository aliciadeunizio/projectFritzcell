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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
