import 'package:flutter/material.dart';
import 'package:nutriis/notifications.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Tamaño de letra",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                NotiService.mostrarNotificacion();
              },
              child: const Text("Probar notificación"),
            ),
          ],
        ),
      ),
    );
  }
}