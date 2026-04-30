import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../database/database.dart';
import '../main.dart';
import '../pages/recipedetail.dart';

class NotiService {
  static bool activadas = true;

  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int _id = 0;

  static Future<void> init() async {
    await notificationsPlugin
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
    ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;

        if (payload != null) {
          final recetaId = int.tryParse(payload);

          if (recetaId != null) {
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (_) => Recipedetail(id: recetaId),
              ),
            );
          }
        }
      },
    );
  }

  static Future<void> _mostrar(String titulo, String cuerpo,
      {String? payload}) async {

    if (!activadas) return;
    
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'canal_id',
      'Canal NutriIS',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      _id++,
      titulo,
      cuerpo,
      details,
      payload: payload,
    );
  }

  static Future<void> notificacionSimple() async {
    await _mostrar(
      'NutriIS',
      'Recuerda revisar tus recetas',
    );
  }

  static Future<void> notificacionRecetaAleatoria() async {
    final db = AppDatabase();
    final recetas = await db.obtenerRecetas();

    if (recetas.isEmpty) return;

    recetas.shuffle(Random());
    final receta = recetas.first;

    await _mostrar(
      '🍽️ Receta del día',
      'Prueba: ${receta.nombre}',
      payload: receta.id.toString(),
    );
  }

  static Future<void> notificacionPorCategoria(String categoria) async {
    final db = AppDatabase();
    final recetas = await db.obtenerRecetas();

    List<Receta> filtradas = [];

    for (var receta in recetas) {
      final cats = await db.obtenerCategoriasDeReceta(receta.id);

      if (cats.contains(categoria)) {
        filtradas.add(receta);
      }
    }

    if (filtradas.isEmpty) return;

    filtradas.shuffle();
    final receta = filtradas.first;

    await _mostrar(
      '🥗 $categoria',
      'Te recomendamos: ${receta.nombre}',
      payload: receta.id.toString(),
    );
  }

  static Future<void> notificacionRandom() async {
    final random = Random().nextInt(3);

    switch (random) {
      case 0:
        await notificacionRecetaAleatoria();
        break;
      case 1:
        await notificacionPorCategoria('Desayuno');
        break;
      case 2:
        await notificacionPorCategoria('Cena');
        break;
    }
  }

  static Future<void> notificacionPorHora() async {
    final hora = DateTime.now().hour;

    if (hora < 12) {
      await notificacionPorCategoria('Desayuno');
    } else if (hora < 18) {
      await notificacionPorCategoria('Almuerzo');
    } else {
      await notificacionPorCategoria('Cena');
    }
  }
}