import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../l10n/app_localizations.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;

  const TaskEditScreen({super.key, this.task});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  DateTime? _alarmDateTime;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.task != null;
    _nameController = TextEditingController(text: widget.task?.name ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _alarmDateTime = widget.task?.alarmDateTime;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
              icon: const Icon(Icons.save),
              onPressed: _saveTask,
              iconSize: 24,
              color: Colors.green,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            if (_isEditing)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: _deleteTask,
                iconSize: 24,
                color: Colors.red,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).taskName,
                border: const OutlineInputBorder(),
              ),
              maxLength: 30,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).taskDescription,
                border: const OutlineInputBorder(),
              ),
              maxLines: 5,
              maxLength: 1000,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _showDateTimePickerDialog(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).alarmDateTime,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _alarmDateTime != null
                                ? _formatDateTime(_alarmDateTime!)
                                : AppLocalizations.of(context).setAlarm,
                            style: TextStyle(
                              color: _alarmDateTime != null
                                  ? null
                                  : Colors.grey.shade600,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.alarm,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDateTimePickerDialog() {
    final now = DateTime.now();
    DateTime tempDateTime = _alarmDateTime ?? now;
    
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Picker
                  StatefulBuilder(
                    builder: (context, setDialogState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberPicker(
                            tempDateTime.day,
                            1,
                            31,
                            (value) {
                              setDialogState(() {
                                tempDateTime = DateTime(
                                  tempDateTime.year,
                                  tempDateTime.month,
                                  value,
                                  tempDateTime.hour,
                                  tempDateTime.minute,
                                );
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text('/', style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, 
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            )),
                          ),
                          _buildNumberPicker(
                            tempDateTime.month,
                            1,
                            12,
                            (value) {
                              setDialogState(() {
                                tempDateTime = DateTime(
                                  tempDateTime.year,
                                  value,
                                  tempDateTime.day,
                                  tempDateTime.hour,
                                  tempDateTime.minute,
                                );
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text('/', style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, 
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            )),
                          ),
                          _buildNumberPicker(
                            tempDateTime.year,
                            now.year,
                            now.year + 5,
                            (value) {
                              setDialogState(() {
                                tempDateTime = DateTime(
                                  value,
                                  tempDateTime.month,
                                  tempDateTime.day,
                                  tempDateTime.hour,
                                  tempDateTime.minute,
                                );
                              });
                            },
                          ),
                        ],
                      );
                    }
                  ),
                  
                  const SizedBox(height: 5),
                  
                  // Time Picker
                  StatefulBuilder(
                    builder: (context, setDialogState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNumberPicker(
                            tempDateTime.hour,
                            0,
                            23,
                            (value) {
                              setDialogState(() {
                                tempDateTime = DateTime(
                                  tempDateTime.year,
                                  tempDateTime.month,
                                  tempDateTime.day,
                                  value,
                                  tempDateTime.minute,
                                );
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(':', style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, 
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            )),
                          ),
                          _buildNumberPicker(
                            tempDateTime.minute,
                            0,
                            59,
                            (value) {
                              setDialogState(() {
                                tempDateTime = DateTime(
                                  tempDateTime.year,
                                  tempDateTime.month,
                                  tempDateTime.day,
                                  tempDateTime.hour,
                                  value,
                                );
                              });
                            },
                          ),
                        ],
                      );
                    }
                  ),
                  
                  const SizedBox(height: 5),
                  
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _alarmDateTime = null;
                            });
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _alarmDateTime = tempDateTime;
                            });
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.check,
                              size: 16,
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
  }

  Widget _buildNumberPicker(int initialValue, int minValue, int maxValue, Function(int) onChanged) {
    return Container(
      width: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                int newValue = initialValue + 1;
                if (newValue > maxValue) newValue = minValue;
                onChanged(newValue);
              },
              child: const Icon(Icons.arrow_drop_up, size: 12),
            ),
            Text(
              initialValue.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontSize: 10, 
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            InkWell(
              onTap: () {
                int newValue = initialValue - 1;
                if (newValue < minValue) newValue = maxValue;
                onChanged(newValue);
              },
              child: const Icon(Icons.arrow_drop_down, size: 12),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _saveTask() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).taskName),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final task = Task(
      id: widget.task?.id ?? const Uuid().v4(),
      name: _nameController.text,
      description: _descriptionController.text,
      alarmDateTime: _alarmDateTime,
    );

    Navigator.pop(context, task);
  }

  void _deleteTask() {
    showDialog(
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
                    AppLocalizations.of(context).confirmDeleteMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.check,
                              size: 24,
                              color: Colors.red,
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
  }
} 