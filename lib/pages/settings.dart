import 'package:flutter/material.dart';
import 'package:nutriis/notifications.dart';

class FontSizeController {
  static ValueNotifier<double> scale = ValueNotifier(1.0);
}

class ThemeController {
  static ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double selectedScale = 1.0;
  bool notificacionesActivas = true;
  bool modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: FontSizeController.scale,
      builder: (context, scale, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Configuración")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: Text("Tamaño de letra", style: TextStyle(fontSize: 16 * scale)),
                  trailing: DropdownButton<double>(
                    value: selectedScale,
                    items: [
                      DropdownMenuItem(value: 0.8, child: Text("Pequeño", style: TextStyle(fontSize: 16 * scale))),
                      DropdownMenuItem(value: 1.0, child: Text("Mediano", style: TextStyle(fontSize: 16 * scale))),
                      DropdownMenuItem(value: 1.3, child: Text("Grande", style: TextStyle(fontSize: 16 * scale))),
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
                ),
                SwitchListTile(
                  title: Text("Notificaciones", style: TextStyle(fontSize: 16 * scale)),
                  value: notificacionesActivas,
                  onChanged: (value) {
                    setState(() {
                      notificacionesActivas = value;
                      NotiService.activadas = value;
                    });
                  },
                ),

                SwitchListTile(
                  title: Text("Modo oscuro", style: TextStyle(fontSize: 16 * scale)),
                  value: modoOscuro,
                  onChanged: (value) {
                    setState(() {
                      modoOscuro = value;
                    });

                    ThemeController.themeMode.value =
                        value ? ThemeMode.dark : ThemeMode.light;
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
    );
  }
}