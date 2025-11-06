import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class DiagnosticoPage extends StatefulWidget {
  final String tipo;
  const DiagnosticoPage({super.key, required this.tipo});

  @override
  State<DiagnosticoPage> createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  int etapa = 1;
  final int totalEtapas = 3;
  bool finalizado = false;
  bool resultadoPositivo = false;

  final _firestore = FirestoreService();

  void _responder(String resposta) async {
    bool respostaSim = resposta == "Sim";

    if (etapa < totalEtapas) {
      setState(() => etapa++);
    } else {
      resultadoPositivo = respostaSim;

      await _firestore.registrarDiagnostico(
        tipo: widget.tipo,
        concluido: resultadoPositivo,
      );

      setState(() => finalizado = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diagnóstico - ${widget.tipo}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: finalizado
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      resultadoPositivo ? Icons.check_circle : Icons.error,
                      color: resultadoPositivo ? Colors.green : Colors.red,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      resultadoPositivo
                          ? "Diagnóstico concluído com SUCESSO!"
                          : "Diagnóstico concluído com FALHA detectada!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Diagnóstico '${widget.tipo}' finalizado.",
                            ),
                          ),
                        );
                      },
                      child: const Text("Voltar"),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[200],
                      child: Text(
                        "Etapa $etapa de $totalEtapas",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      _perguntaAtual(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () => _responder("Sim"),
                      icon: const Icon(Icons.thumb_up),
                      label: const Text("Sim"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _responder("Não"),
                      icon: const Icon(Icons.thumb_down),
                      label: const Text("Não"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  String _perguntaAtual() {
    switch (widget.tipo) {
      case "Botão de energia":
        return [
          "O botão liga/desliga está respondendo ao toque?",
          "O botão está solto ou afundado?",
          "O aparelho liga ao pressionar o botão?",
        ][etapa - 1];
      case "Tela":
        return [
          "A tela liga normalmente?",
          "Há rachaduras visíveis?",
          "O touch está funcionando em todas as áreas?",
        ][etapa - 1];
      case "Bateria":
        return [
          "O aparelho liga apenas conectado ao carregador?",
          "A bateria descarrega rapidamente?",
          "O aparelho superaquece durante o uso?",
        ][etapa - 1];
      case "Conector":
        return [
          "O cabo encaixa firmemente no conector?",
          "O aparelho carrega ao conectar o cabo?",
          "Há oxidação ou sujeira visível no conector?",
        ][etapa - 1];
      default:
        return "Pergunta não definida.";
    }
  }
}
