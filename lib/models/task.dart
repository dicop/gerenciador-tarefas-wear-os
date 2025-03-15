class Task {
  final String id;
  String name;
  String description;
  bool isCompleted;
  DateTime? alarmDateTime;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.name,
    this.description = '',
    this.isCompleted = false,
    this.alarmDateTime,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isCompleted': isCompleted,
      'alarmDateTime': alarmDateTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      alarmDateTime: json['alarmDateTime'] != null
          ? DateTime.parse(json['alarmDateTime'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
} 