import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final String questionText; // texto da pergunta
  final int currentStep; // etapa atual
  final int totalSteps; // total de etapas
  final ValueChanged<bool> onAnswered; // callback que retorna true/false

  const QuestionWidget({
    super.key,
    required this.questionText,
    required this.currentStep,
    required this.totalSteps,
    required this.onAnswered,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool? _answer; // null = ainda não respondeu

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // indicador de progresso
        Text(
          'Etapa ${widget.currentStep} de ${widget.totalSteps}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),

        // texto da pergunta
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            widget.questionText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),

        // botões de resposta
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _answer = true);
                widget.onAnswered(true);
              },
              icon: const Icon(Icons.check),
              label: const Text('Sim'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _answer = false);
                widget.onAnswered(false);
              },
              icon: const Icon(Icons.close),
              label: const Text('Não'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // feedback visual
        if (_answer != null)
          Text(
            _answer! ? 'Resposta: Sim' : 'Resposta: Não',
            style: TextStyle(
              color: _answer! ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
