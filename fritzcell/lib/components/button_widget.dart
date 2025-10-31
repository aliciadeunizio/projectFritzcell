import 'package:flutter/material.dart';
import 'package:fritzcell/diagnosticPage.dart';

class MenuButton extends StatelessWidget {
  final String titulo;

  const MenuButton({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.blue),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DiagnosticoPage(tipo: titulo)),
          );
        },
        child: Text(titulo, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
