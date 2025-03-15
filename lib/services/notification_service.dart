import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task.dart';
import 'dart:io' show Platform;
import 'dart:typed_data';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  
  factory NotificationService() {
    return _instance;
  }
  
  NotificationService._internal();
  
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    
    // Configurações específicas para Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // Configurações específicas para iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );
    
    // Configurações de inicialização
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Inicializar o plugin
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notificação recebida: ${response.payload}');
      },
    );
    
    // Solicitar permissões explicitamente
    await _requestPermissions();
    
    // Cancelar todas as notificações existentes ao iniciar
    await _notifications.cancelAll();
    
    // Verificar se há notificações pendentes
    final pendingNotifications = await _notifications.pendingNotificationRequests();
    print('Notificações pendentes: ${pendingNotifications.length}');
    for (var notification in pendingNotifications) {
      print('ID: ${notification.id}, Título: ${notification.title}');
    }
  }
  
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Para Android 13 e superior (API level 33)
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
              
      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
        await androidPlugin.requestExactAlarmsPermission();
      }
    } else if (Platform.isIOS) {
      // Para iOS
      final IOSFlutterLocalNotificationsPlugin? iosPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
              
      if (iosPlugin != null) {
        await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: true,
        );
      }
    }
  }

  Future<void> scheduleTaskAlarm(Task task) async {
    if (task.alarmDateTime == null) return;
    
    // Cancelar qualquer alarme existente para esta tarefa
    await cancelAlarm(task.id);

    // Configurações específicas para Android
    final androidDetails = AndroidNotificationDetails(
      'task_alarms',
      'Task Alarms',
      channelDescription: 'Notifications for task alarms',
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      autoCancel: false,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      enableLights: true,
      playSound: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
      visibility: NotificationVisibility.public,
      ticker: 'Alarme de tarefa',
    );

    // Configurações específicas para iOS
    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
      sound: 'default',
    );

    // Configurações gerais da notificação
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    // Verificar se a data do alarme já passou
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(task.alarmDateTime!, tz.local);
    
    // Se a data já passou, não agendar
    if (scheduledDate.isBefore(now)) {
      print('Data do alarme já passou: ${task.alarmDateTime}');
      return;
    }

    try {
      // Agendar a notificação
      await _notifications.zonedSchedule(
        task.id.hashCode,
        'Alarme de Tarefa',
        task.name,
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: task.id,
      );
      print('Alarme agendado para: ${task.alarmDateTime}');
      
      // Verificar se o alarme foi agendado corretamente
      final pendingNotifications = await _notifications.pendingNotificationRequests();
      final scheduled = pendingNotifications.any((notification) => notification.id == task.id.hashCode);
      print('Alarme agendado com sucesso: $scheduled');
    } catch (e) {
      print('Erro ao agendar alarme: $e');
    }
  }

  Future<void> cancelAlarm(String taskId) async {
    await _notifications.cancel(taskId.hashCode);
    print('Alarme cancelado para a tarefa: $taskId');
  }
  
  Future<void> cancelAllAlarms() async {
    await _notifications.cancelAll();
    print('Todos os alarmes foram cancelados');
  }
  
  // Método para testar notificações imediatas
  Future<void> showTestNotification() async {
    final androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Notifications',
      channelDescription: 'Channel for testing notifications',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      enableLights: true,
      ticker: 'Teste de notificação',
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      0,
      'Teste de Notificação',
      'Esta é uma notificação de teste',
      details,
    );
    print('Notificação de teste enviada');
  }
  
  // Método para agendar um alarme de teste para 10 segundos no futuro
  Future<void> scheduleTestAlarm() async {
    final androidDetails = AndroidNotificationDetails(
      'test_alarms',
      'Test Alarms',
      channelDescription: 'Channel for testing alarms',
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      autoCancel: false,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      enableLights: true,
      playSound: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
      visibility: NotificationVisibility.public,
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
      sound: 'default',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = now.add(const Duration(seconds: 10));
    
    try {
      // Cancelar qualquer alarme de teste anterior
      await _notifications.cancel(999);
      
      // Agendar o alarme de teste
      await _notifications.zonedSchedule(
        999,
        'Alarme de Teste',
        'Este é um alarme de teste agendado para 10 segundos no futuro',
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Alarme de teste agendado para: $scheduledDate');
      
      // Verificar se o alarme foi agendado corretamente
      final pendingNotifications = await _notifications.pendingNotificationRequests();
      final scheduled = pendingNotifications.any((notification) => notification.id == 999);
      print('Alarme de teste agendado com sucesso: $scheduled');
    } catch (e) {
      print('Erro ao agendar alarme de teste: $e');
    }
  }
} 