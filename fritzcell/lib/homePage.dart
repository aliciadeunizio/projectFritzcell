import 'package:flutter/material.dart';
import 'estatisticasPage.dart';
import 'diagnosticPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  "Menu de Navegação",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Diagnósticos"),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Estatísticas"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EstatisticasPage()),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Diagnósticos"), centerTitle: true),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Text(
                      "LOGO",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _menuButton(context, "Botão de energia"),
                          _menuButton(context, "Tela"),
                          _menuButton(context, "Bateria"),
                          _menuButton(context, "Conector"),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EstatisticasPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.bar_chart),
                            label: const Text("Estatísticas"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(BuildContext context, String titulo) {
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
        child: Text(titulo),
      ),
    );
  }
}
