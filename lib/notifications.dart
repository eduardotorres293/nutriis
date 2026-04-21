import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(settings);
  }

  static Future<void> mostrarNotificacion() async {
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
      0,
      'NutriIS',
      'Recuerda revisar tus recetas',
      details,
    );
  }
}