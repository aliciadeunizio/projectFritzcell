import 'package:flutter/material.dart';
import 'estatisticasPage.dart';
import 'components/button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 5, 58, 101)),
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
                colors: [Color.fromARGB(255, 5, 58, 101), Colors.white],
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
                    backgroundImage: AssetImage(
                      'assets/images/LogoSimples.jpeg',
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
                          MenuButton(titulo: "Botão de energia"),
                          MenuButton(titulo: "Tela"),
                          MenuButton(titulo: "Bateria"),
                          MenuButton(titulo: "Conector"),
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
}
