import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/task.dart';
import 'screens/splash_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/task_edit_screen.dart';
import 'screens/settings_screen.dart';
import 'services/task_service.dart';
import 'services/notification_service.dart';
import 'providers/theme_provider.dart';
import 'providers/task_provider.dart';
import 'providers/language_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final taskService = TaskService(prefs);
  final notificationService = NotificationService();
  await notificationService.initialize();

  // Pré-carrega as tarefas
  final tasks = await taskService.getTasks();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LanguageProvider(prefs)),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(taskService, tasks),
        ),
        Provider<NotificationService>.value(value: notificationService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();
    
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('pt', ''), // Portuguese
        Locale('es', ''), // Spanish
        Locale('fr', ''), // French
        Locale('zh', ''), // Chinese
        Locale('ja', ''), // Japanese
      ],
      locale: languageProvider.locale,
      home: Builder(
        builder: (context) {
          final notificationService = Provider.of<NotificationService>(context, listen: false);
          
          return Scaffold(
            body: const SplashScreen(),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () {
                    notificationService.showTestNotification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notificação de teste enviada'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  mini: true,
                  child: const Icon(Icons.notifications),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: () {
                    notificationService.scheduleTestAlarm();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alarme de teste agendado para 10 segundos'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  mini: true,
                  child: const Icon(Icons.alarm),
                ),
              ],
            ),
          );
        },
      ),
      routes: {
        '/tasks': (context) {
          final taskProvider = context.watch<TaskProvider>();
          return TaskListScreen(
            tasks: taskProvider.tasks,
            onTaskTap: (task) => _editTask(context, task),
            onTaskLongPress: (task) => _toggleTaskCompletion(context, task),
            onAddTask: () => _addTask(context),
          );
        },
        '/task/edit': (context) => const TaskEditScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }

  Future<void> _addTask(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TaskEditScreen(),
      ),
    );

    if (result != null && result is Task) {
      final taskProvider = context.read<TaskProvider>();
      await taskProvider.addTask(result);
      
      if (result.alarmDateTime != null) {
        final notificationService = context.read<NotificationService>();
        await notificationService.scheduleTaskAlarm(result);
      }
      
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/tasks');
      }
    }
  }

  Future<void> _editTask(BuildContext context, Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    );

    if (result != null) {
      final taskProvider = context.read<TaskProvider>();
      final notificationService = context.read<NotificationService>();
      
      if (result == true) {
        await taskProvider.deleteTask(task.id);
        await notificationService.cancelAlarm(task.id);
      } else if (result is Task) {
        await taskProvider.updateTask(result);
        
        if (result.alarmDateTime != null) {
          await notificationService.scheduleTaskAlarm(result);
        } else {
          await notificationService.cancelAlarm(result.id);
        }
      }
      
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/tasks');
      }
    }
  }

  Future<void> _toggleTaskCompletion(BuildContext context, Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).confirmComplete),
        content: Text(AppLocalizations.of(context).confirmCompleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).confirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final taskProvider = context.read<TaskProvider>();
      final updatedTask = Task(
        id: task.id,
        name: task.name,
        description: task.description,
        isCompleted: !task.isCompleted,
        alarmDateTime: task.alarmDateTime,
        createdAt: task.createdAt,
      );
      await taskProvider.updateTask(updatedTask);
      
      // Se a tarefa foi marcada como concluída, cancelar o alarme
      if (updatedTask.isCompleted && updatedTask.alarmDateTime != null) {
        final notificationService = context.read<NotificationService>();
        await notificationService.cancelAlarm(updatedTask.id);
      }
    }
  }
}
