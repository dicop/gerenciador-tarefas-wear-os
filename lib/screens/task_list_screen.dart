import 'package:flutter/material.dart';
import '../models/task.dart';
import '../l10n/app_localizations.dart';

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
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: onAddTask,
              iconSize: 28,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              iconSize: 24,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            elevation: 1,
            child: InkWell(
              onTap: () => onTaskTap(task),
              onLongPress: () => onTaskLongPress(task),
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        task.isCompleted ? Icons.task_alt : Icons.pending_outlined,
                        color: task.isCompleted ? Colors.green : Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: task.description.isEmpty
                            ? Center(
                                child: Text(
                                  task.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                  Text(
                                    task.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 