import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
        Locale('hi', ''), // Hindi
        Locale('ar', ''), // Arabic
        Locale('bn', ''), // Bengali
        Locale('ru', ''), // Russian
        Locale('pa', ''), // Punjabi
      ],
      locale: languageProvider.locale,
      home: Builder(
        builder: (context) {
          
          return const Scaffold(
            body: SplashScreen(),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
      CupertinoPageRoute(
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
        
        // Exibir mensagem de sucesso usando overlay simples em vez de SnackBar
        Future.delayed(const Duration(milliseconds: 100), () {
          _showSuccessMessage(context, 'Tarefa salva com sucesso', Colors.green);
        });
      }
    }
  }

  Future<void> _editTask(BuildContext context, Task task) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    );

    if (result != null) {
      final taskProvider = context.read<TaskProvider>();
      final notificationService = context.read<NotificationService>();
      
      if (result == true) {
        await taskProvider.deleteTask(task.id);
        await notificationService.cancelAlarm(task.id);
        
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/tasks');
          
          // Exibir mensagem de exclusão
          Future.delayed(const Duration(milliseconds: 100), () {
            _showSuccessMessage(context, 'Tarefa excluída com sucesso', Colors.red);
          });
        }
      } else if (result is Task) {
        await taskProvider.updateTask(result);
        
        if (result.alarmDateTime != null) {
          await notificationService.scheduleTaskAlarm(result);
        } else {
          await notificationService.cancelAlarm(result.id);
        }
        
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/tasks');
          
          // Exibir mensagem de sucesso
          Future.delayed(const Duration(milliseconds: 100), () {
            _showSuccessMessage(context, 'Tarefa salva com sucesso', Colors.green);
          });
        }
      }
    }
  }

  Future<void> _toggleTaskCompletion(BuildContext context, Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
        child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context).confirmCompleteMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context, false),
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context, true),
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.check,
                              size: 24,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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

  // Método para exibir mensagem de sucesso usando SnackBar
  void _showSuccessMessage(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
