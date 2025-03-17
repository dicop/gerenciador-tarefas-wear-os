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
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.task != null;
    _nameController = TextEditingController(text: widget.task?.name ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _alarmDateTime = widget.task?.alarmDateTime;
    _isCompleted = widget.task?.isCompleted ?? false;
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.black : Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                        _isEditing ? Icons.edit_note : Icons.note_add_outlined,
                        size: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context).task,
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
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).taskName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey[900] : Colors.white,
                  counterText: '',
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  isDense: true,
                ),
                maxLength: 30,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).taskDescription,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey[900] : Colors.white,
                  counterText: '',
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  isDense: true,
                ),
                maxLines: 3,
                maxLength: 1000,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _showDateTimePickerDialog(),
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[900] : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
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
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.alarm,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[700]! : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).taskCompleted,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Switch(
                      value: _isCompleted,
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = value;
                        });
                      },
                      activeColor: Colors.green,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Espaço para os botões flutuantes
            ],
          ),
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
              heroTag: 'saveTask',
              onPressed: _saveTask,
              backgroundColor: Colors.green,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.save, size: 18),
            ),
            if (_isEditing) ...[
              const SizedBox(width: 8),
              FloatingActionButton.small(
                heroTag: 'deleteTask',
                onPressed: _deleteTask,
                backgroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.delete, size: 18),
              ),
            ],
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showDateTimePickerDialog() {
    // Remover o foco de qualquer campo de texto
    FocusScope.of(context).unfocus();
    
    final now = DateTime.now();
    
    // Se estiver criando uma nova tarefa ou se o alarme foi modificado,
    // garantir que a data inicial seja futura
    DateTime tempDateTime;
    
    if (_alarmDateTime == null) {
      // Se não há data definida, usar data atual + 1 hora
      tempDateTime = now.add(const Duration(hours: 1));
    } else if (_alarmDateTime!.isBefore(now) && widget.task == null) {
      // Se é uma nova tarefa e a data é passada, usar data atual + 1 hora
      tempDateTime = now.add(const Duration(hours: 1));
    } else {
      // Caso contrário, usar a data existente
      tempDateTime = _alarmDateTime!;
    }
    
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  
                  const SizedBox(height: 12),
                  
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  
                  const SizedBox(height: 10),
                  
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
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
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
                              size: 20,
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
              child: const Icon(Icons.arrow_drop_up, size: 20),
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
              child: const Icon(Icons.arrow_drop_down, size: 20),
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
          content: Center(child: Text(AppLocalizations.of(context).taskName)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validação da data e hora do alarme
    if (_alarmDateTime != null) {
      final now = DateTime.now();
      
      // Verificar se é uma nova tarefa ou se o alarme foi alterado
      final isNewTask = widget.task == null;
      final alarmWasModified = widget.task != null && 
          (widget.task!.alarmDateTime == null || 
           _alarmDateTime!.compareTo(widget.task!.alarmDateTime!) != 0);
      
      // Validar apenas se for nova tarefa ou se o alarme foi modificado
      if ((isNewTask || alarmWasModified) && _alarmDateTime!.isBefore(now)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text(AppLocalizations.of(context).futureDateRequired)),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    final task = Task(
      id: widget.task?.id ?? const Uuid().v4(),
      name: _nameController.text,
      description: _descriptionController.text,
      alarmDateTime: _alarmDateTime,
      isCompleted: _isCompleted,
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