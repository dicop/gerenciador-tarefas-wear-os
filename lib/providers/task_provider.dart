import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService;
  List<Task> _tasks = [];

  TaskProvider(this._taskService, List<Task> initialTasks) {
    _tasks = initialTasks;
  }

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _taskService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskService.saveTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _taskService.saveTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(String id) async {
    await _taskService.toggleTaskCompletion(id);
    await loadTasks();
  }
} 