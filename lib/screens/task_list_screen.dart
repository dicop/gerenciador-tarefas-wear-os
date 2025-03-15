import 'package:flutter/material.dart';
import '../models/task.dart';

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
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80), // Espaço para os botões flutuantes
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.small(
              heroTag: 'addTask',
              onPressed: onAddTask,
              child: const Icon(Icons.add_circle, size: 18),
            ),
            FloatingActionButton.small(
              heroTag: 'settings',
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Icon(Icons.settings, size: 18),
            ),
          ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
} 