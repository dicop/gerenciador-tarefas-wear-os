import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _initialize();
  }

  Future<void> _initialize() async {
    // Aguarda a animação
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    // Força o carregamento inicial das tarefas
    await context.read<TaskProvider>().loadTasks();
    
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializationFuture,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.watch,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                )
                    .animate()
                    .fadeIn(duration: 1.seconds)
                    .scale(duration: 1.seconds)
                    .then()
                    .shake(duration: 0.5.seconds),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).appTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                )
                    .animate()
                    .fadeIn(delay: 500.milliseconds, duration: 1.seconds)
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          );
        },
      ),
    );
  }
} 