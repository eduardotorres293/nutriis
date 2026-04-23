import 'package:flutter/material.dart';
import 'package:nutriis/notifications.dart';
class FontSizeController {
  static ValueNotifier<double> scale = ValueNotifier(1.0);
}
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
            
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                FontSizeController.scale.value = 0.8; // pequeño
              },
              child: const Text("Pequeño"),
            ),

            ElevatedButton(
              onPressed: () {
                FontSizeController.scale.value = 1.0; // mediano
              },
              child: const Text("Mediano"),
            ),

            ElevatedButton(
              onPressed: () {
                FontSizeController.scale.value = 1.3; // grande
              },
              child: const Text("Grande"),
            ),
          ],
        ),
      ),
    );
  }
}