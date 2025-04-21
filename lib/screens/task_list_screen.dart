import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/task.dart';
import '../l10n/app_localizations.dart';
import '../screens/settings_screen.dart';

class TaskListScreen extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskTap;
  final Function(Task) onTaskLongPress;
  final VoidCallback onAddTask;

  const TaskListScreen({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskLongPress,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.black : Colors.grey[100],
      body: SafeArea(
        child: tasks.isEmpty 
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title at the top
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[850]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.task_alt_outlined,
                                size: 14,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppLocalizations.of(context).tasks,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    Icon(
                      Icons.task_outlined,
                      size: 40,
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white54 : Colors.black38,
                    ),
                    Text(
                      AppLocalizations.of(context).noTasks,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.white54 : Colors.black38,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3, // Espaço para permitir rolagem
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80, left: 8, right: 8, top: 16),
                itemCount: tasks.length + 1, // +1 for the title
                itemBuilder: (context, index) {
                  // Title item
                  if (index == 0) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[850]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.task_alt_outlined,
                              size: 14,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(context).tasks,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  // Task items
                  final task = tasks[index - 1]; // Adjust index for tasks
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[800]! : Colors.grey[300]!,
                        width: 0.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => onTaskTap(task),
                      onLongPress: () => onTaskLongPress(task),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: task.isCompleted 
                                    ? Colors.green.withOpacity(0.1) 
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                task.isCompleted ? Icons.star : Icons.star_border,
                                color: task.isCompleted ? Colors.green : Colors.grey,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: task.description.isEmpty
                                  ? Text(
                                      task.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold, 
                                        fontSize: 12,
                                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          task.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, 
                                            fontSize: 12,
                                            decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                          ),
                                        ),
                                        Text(
                                          task.description,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            if (task.alarmDateTime != null)
                              Icon(
                                Icons.alarm,
                                size: 14,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.white70 : Colors.black54,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'addTask',
              onPressed: onAddTask,
              backgroundColor: Colors.blue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.add_circle, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
            FloatingActionButton.small(
              heroTag: 'settings',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              backgroundColor: Colors.purple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.settings, size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
} 