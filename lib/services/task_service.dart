import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskService {
  static const String _storageKey = 'tasks';
  final SharedPreferences _prefs;

  TaskService(this._prefs);

  Future<List<Task>> getTasks() async {
    final String? tasksJson = _prefs.getString(_storageKey);
    if (tasksJson == null) return [];

    final List<dynamic> tasksList = json.decode(tasksJson);
    return tasksList.map((json) => Task.fromJson(json)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Ordena por data de criação (mais recentes primeiro)
  }

  Future<void> saveTask(Task task) async {
    final tasks = await getTasks();
    final existingIndex = tasks.indexWhere((t) => t.id == task.id);
    
    if (existingIndex >= 0) {
      tasks[existingIndex] = task;
    } else {
      tasks.add(task);
    }

    final tasksJson = json.encode(tasks.map((t) => t.toJson()).toList());
    await _prefs.setString(_storageKey, tasksJson);
  }

  Future<void> deleteTask(String id) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    
    final tasksJson = json.encode(tasks.map((t) => t.toJson()).toList());
    await _prefs.setString(_storageKey, tasksJson);
  }

  Future<void> toggleTaskCompletion(String id) async {
    final tasks = await getTasks();
    final taskIndex = tasks.indexWhere((t) => t.id == id);
    
    if (taskIndex >= 0) {
      tasks[taskIndex].isCompleted = !tasks[taskIndex].isCompleted;
      final tasksJson = json.encode(tasks.map((t) => t.toJson()).toList());
      await _prefs.setString(_storageKey, tasksJson);
    }
  }
} 