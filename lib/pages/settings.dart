import 'package:flutter/material.dart';
import 'package:nutriis/notifications.dart';
class FontSizeController {
  static ValueNotifier<double> scale = ValueNotifier(1.0);
}
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double selectedScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración"), backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Tamaño de letra",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            DropdownButton<double>(
              value: selectedScale,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 0.8, child: Text("Pequeño")),
                DropdownMenuItem(value: 1.0, child: Text("Mediano")),
                DropdownMenuItem(value: 1.3, child: Text("Grande")),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedScale = value;
                  });
                  FontSizeController.scale.value = value;
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                NotiService.notificacionRandom();
              },
              child: const Text("Probar notificación"),
            ),
          ],
        ),
      ),
    );
  }
}