import 'package:flutter/material.dart';

class EstatisticasPage extends StatelessWidget {
  const EstatisticasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dados = [
      {"nome": "Tela", "casos": 45.0},
      {"nome": "Botão", "casos": 30.0},
      {"nome": "Conector", "casos": 17.0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Estatísticas")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<String>(
              value: "Mês/Ano",
              items: const [
                DropdownMenuItem(value: "Mês/Ano", child: Text("Mês/Ano")),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  final item = dados[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: (item["casos"] as double) / 50,
                        minHeight: 15,
                        color: Colors.blue,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${item["nome"]} - ${item["casos"]} casos",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
