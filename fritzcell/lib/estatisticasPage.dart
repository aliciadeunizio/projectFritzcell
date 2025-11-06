import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  final _firestore = FirebaseFirestore.instance;

  late int mesSelecionado;
  late int anoSelecionado;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('pt_BR', null);

    final agora = DateTime.now();
    mesSelecionado = agora.month;
    anoSelecionado = agora.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estatísticas")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: mesSelecionado,
                    items: List.generate(12, (i) {
                      final mes = i + 1;
                      return DropdownMenuItem(
                        value: mes,
                        child: Text(
                          DateFormat.MMMM('pt_BR').format(DateTime(0, mes)),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) setState(() => mesSelecionado = value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: anoSelecionado,
                    items: List.generate(5, (i) {
                      final ano = DateTime.now().year - i;
                      return DropdownMenuItem(value: ano, child: Text("$ano"));
                    }),
                    onChanged: (value) {
                      if (value != null) setState(() => anoSelecionado = value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('diagnosticos').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  final filtrados = docs.where((doc) {
                    final concluido = doc['concluido'] == true;
                    final rawData = doc['data'];
                    DateTime? data;

                    if (rawData is Timestamp) {
                      data = rawData.toDate();
                    } else if (rawData is String) {
                      data = DateTime.tryParse(rawData);
                    }

                    if (data == null) return false;
                    return concluido &&
                        data.month == mesSelecionado &&
                        data.year == anoSelecionado;
                  }).toList();

                  final Map<String, int> contagem = {};
                  for (var doc in filtrados) {
                    final tipo = doc['tipo'] as String? ?? 'Desconhecido';
                    contagem[tipo] = (contagem[tipo] ?? 0) + 1;
                  }

                  if (contagem.isEmpty) {
                    return const Center(
                      child: Text(
                        "Nenhum diagnóstico concluído neste período.",
                      ),
                    );
                  }

                  final total = contagem.values.fold<int>(0, (a, b) => a + b);

                  return ListView(
                    children: contagem.entries.map((e) {
                      final porcentagem = e.value / total;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              value: porcentagem,
                              minHeight: 15,
                              color: Colors.blue,
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${e.key} - ${e.value} casos (${(porcentagem * 100).toStringAsFixed(1)}%)",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
