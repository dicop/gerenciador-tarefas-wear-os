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
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.black : Colors.grey[100],
      body: FutureBuilder(
        future: _initializationFuture,
        builder: (context, snapshot) {
          return Container(
            color: const Color(0xFF000033),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/dicop.png',
                    width: double.infinity,
                    height: 120,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 