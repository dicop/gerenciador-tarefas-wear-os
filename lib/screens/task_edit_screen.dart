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
  final _formKey = GlobalKey<FormState>();

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
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).taskNameRequired;
                        }
                        return null;
                      },
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
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
                    TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).taskDescriptionRequired;
                        }
                        return null;
                      },
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
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
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
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
          ),
          // Botão de voltar posicionado no meio do lado esquerdo
          Positioned(
            left: 6,
            top: MediaQuery.of(context).size.height / 2 - 15, // Centraliza verticalmente
            child: SizedBox(
              height: 30,
              width: 30,
              child: FloatingActionButton(
                heroTag: 'backBtn',
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[700]!
                        : Colors.grey[300]!,
                    width: 0,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ],
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

    // Variáveis para controlar qual campo está selecionado
    String selectedDateField = 'day'; // 'day', 'month', 'year'
    String selectedTimeField = 'hour'; // 'hour', 'minute'
    
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2),
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
                          // Decrease button for date
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: () {
                              setDialogState(() {
                                switch (selectedDateField) {
                                  case 'day':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day - 1,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'month':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month - 1,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'year':
                                    tempDateTime = DateTime(
                                      tempDateTime.year - 1,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                }
                              });
                            },
                          ),
                          // Date fields
                          GestureDetector(
                            onTap: () => setDialogState(() => selectedDateField = 'day'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedDateField == 'day' 
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: selectedDateField == 'day'
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                tempDateTime.day.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedDateField == 'day' ? FontWeight.bold : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Text('/', style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                          )),
                          GestureDetector(
                            onTap: () => setDialogState(() => selectedDateField = 'month'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedDateField == 'month'
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: selectedDateField == 'month'
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                tempDateTime.month.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedDateField == 'month' ? FontWeight.bold : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Text('/', style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                          )),
                          GestureDetector(
                            onTap: () => setDialogState(() => selectedDateField = 'year'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedDateField == 'year'
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: selectedDateField == 'year'
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                tempDateTime.year.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedDateField == 'year' ? FontWeight.bold : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          // Increase button for date
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              setDialogState(() {
                                switch (selectedDateField) {
                                  case 'day':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day + 1,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'month':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month + 1,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'year':
                                    tempDateTime = DateTime(
                                      tempDateTime.year + 1,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                    break;
                                }
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
                          // Decrease button for time
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: () {
                              setDialogState(() {
                                switch (selectedTimeField) {
                                  case 'hour':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour - 1,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'minute':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute - 1,
                                    );
                                    break;
                                }
                              });
                            },
                          ),
                          // Time fields
                          GestureDetector(
                            onTap: () => setDialogState(() => selectedTimeField = 'hour'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedTimeField == 'hour'
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: selectedTimeField == 'hour'
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                tempDateTime.hour.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedTimeField == 'hour' ? FontWeight.bold : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Text(':', style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                          )),
                          GestureDetector(
                            onTap: () => setDialogState(() => selectedTimeField = 'minute'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedTimeField == 'minute'
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: selectedTimeField == 'minute'
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                tempDateTime.minute.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedTimeField == 'minute' ? FontWeight.bold : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          // Increase button for time
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              setDialogState(() {
                                switch (selectedTimeField) {
                                  case 'hour':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour + 1,
                                      tempDateTime.minute,
                                    );
                                    break;
                                  case 'minute':
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute + 1,
                                    );
                                    break;
                                }
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) {
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

    // Retornar à tela anterior com a tarefa salva
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