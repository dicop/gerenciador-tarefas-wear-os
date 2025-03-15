import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
  ];

  String get appTitle {
    switch (locale.languageCode) {
      case 'pt':
        return 'Gerenciador de Tarefas';
      case 'en':
        return 'Task Manager';
      case 'es':
        return 'Gestor de Tareas';
      case 'fr':
        return 'Gestionnaire de Tâches';
      case 'zh':
        return '任务管理器';
      case 'ja':
        return 'タスクマネージャー';
      default:
        return 'Task Manager';
    }
  }

  String get addTask {
    switch (locale.languageCode) {
      case 'pt':
        return 'Adicionar Tarefa';
      case 'en':
        return 'Add Task';
      case 'es':
        return 'Agregar Tarea';
      case 'fr':
        return 'Ajouter une Tâche';
      case 'zh':
        return '添加任务';
      case 'ja':
        return 'タスクを追加';
      default:
        return 'Add Task';
    }
  }

  String get editTask {
    switch (locale.languageCode) {
      case 'pt':
        return 'Editar Tarefa';
      case 'en':
        return 'Edit Task';
      case 'es':
        return 'Editar Tarea';
      case 'fr':
        return 'Modifier la Tâche';
      case 'zh':
        return '编辑任务';
      case 'ja':
        return 'タスクを編集';
      default:
        return 'Edit Task';
    }
  }

  String get taskName {
    switch (locale.languageCode) {
      case 'pt':
        return 'Nome da Tarefa';
      case 'en':
        return 'Task Name';
      case 'es':
        return 'Nombre de la Tarea';
      case 'fr':
        return 'Nom de la Tâche';
      case 'zh':
        return '任务名称';
      case 'ja':
        return 'タスク名';
      default:
        return 'Task Name';
    }
  }

  String get taskDescription {
    switch (locale.languageCode) {
      case 'pt':
        return 'Descrição';
      case 'en':
        return 'Description';
      case 'es':
        return 'Descripción';
      case 'fr':
        return 'Description';
      case 'zh':
        return '描述';
      case 'ja':
        return '説明';
      default:
        return 'Description';
    }
  }

  String get alarmDateTime {
    switch (locale.languageCode) {
      case 'pt':
        return 'Data/Hora do Alarme';
      case 'en':
        return 'Alarm Date/Time';
      case 'es':
        return 'Fecha/Hora de Alarma';
      case 'fr':
        return 'Date/Heure de l\'Alarme';
      case 'zh':
        return '闹钟日期/时间';
      case 'ja':
        return 'アラーム日時';
      default:
        return 'Alarm Date/Time';
    }
  }

  String get save {
    switch (locale.languageCode) {
      case 'pt':
        return 'Salvar';
      case 'en':
        return 'Save';
      case 'es':
        return 'Guardar';
      case 'fr':
        return 'Enregistrer';
      case 'zh':
        return '保存';
      case 'ja':
        return '保存';
      default:
        return 'Save';
    }
  }

  String get delete {
    switch (locale.languageCode) {
      case 'pt':
        return 'Excluir';
      case 'en':
        return 'Delete';
      case 'es':
        return 'Eliminar';
      case 'fr':
        return 'Supprimer';
      case 'zh':
        return '删除';
      case 'ja':
        return '削除';
      default:
        return 'Delete';
    }
  }

  String get confirmDelete {
    switch (locale.languageCode) {
      case 'pt':
        return 'Confirmar Exclusão';
      case 'en':
        return 'Confirm Delete';
      case 'es':
        return 'Confirmar Eliminación';
      case 'fr':
        return 'Confirmer la Suppression';
      case 'zh':
        return '确认删除';
      case 'ja':
        return '削除の確認';
      default:
        return 'Confirm Delete';
    }
  }

  String get confirmDeleteMessage {
    switch (locale.languageCode) {
      case 'pt':
        return 'Tem certeza que deseja excluir esta tarefa?';
      case 'en':
        return 'Are you sure you want to delete this task?';
      case 'es':
        return '¿Está seguro de que desea eliminar esta tarea?';
      case 'fr':
        return 'Êtes-vous sûr de vouloir supprimer cette tâche ?';
      case 'zh':
        return '确定要删除这个任务吗？';
      case 'ja':
        return 'このタスクを削除してもよろしいですか？';
      default:
        return 'Are you sure you want to delete this task?';
    }
  }

  String get confirmComplete {
    switch (locale.languageCode) {
      case 'pt':
        return 'Confirmar Conclusão';
      case 'en':
        return 'Confirm Completion';
      case 'es':
        return 'Confirmar Finalización';
      case 'fr':
        return 'Confirmer la Fin';
      case 'zh':
        return '确认完成';
      case 'ja':
        return '完了の確認';
      default:
        return 'Confirm Completion';
    }
  }

  String get confirmCompleteMessage {
    switch (locale.languageCode) {
      case 'pt':
        return 'Deseja marcar esta tarefa como concluída?';
      case 'en':
        return 'Do you want to mark this task as completed?';
      case 'es':
        return '¿Desea marcar esta tarea como completada?';
      case 'fr':
        return 'Voulez-vous marquer cette tâche comme terminée ?';
      case 'zh':
        return '是否将此任务标记为已完成？';
      case 'ja':
        return 'このタスクを完了としてマークしますか？';
      default:
        return 'Do you want to mark this task as completed?';
    }
  }

  String get cancel {
    switch (locale.languageCode) {
      case 'pt':
        return 'Cancelar';
      case 'en':
        return 'Cancel';
      case 'es':
        return 'Cancelar';
      case 'fr':
        return 'Annuler';
      case 'zh':
        return '取消';
      case 'ja':
        return 'キャンセル';
      default:
        return 'Cancel';
    }
  }

  String get confirm {
    switch (locale.languageCode) {
      case 'pt':
        return 'Confirmar';
      case 'en':
        return 'Confirm';
      case 'es':
        return 'Confirmar';
      case 'fr':
        return 'Confirmer';
      case 'zh':
        return '确认';
      case 'ja':
        return '確認';
      default:
        return 'Confirm';
    }
  }

  String get settings {
    switch (locale.languageCode) {
      case 'pt':
        return 'Configurações';
      case 'en':
        return 'Settings';
      case 'es':
        return 'Configuración';
      case 'fr':
        return 'Paramètres';
      case 'zh':
        return '设置';
      case 'ja':
        return '設定';
      default:
        return 'Settings';
    }
  }

  String get theme {
    switch (locale.languageCode) {
      case 'pt':
        return 'Tema';
      case 'en':
        return 'Theme';
      case 'es':
        return 'Tema';
      case 'fr':
        return 'Thème';
      case 'zh':
        return '主题';
      case 'ja':
        return 'テーマ';
      default:
        return 'Theme';
    }
  }

  String get darkMode {
    switch (locale.languageCode) {
      case 'pt':
        return 'Modo Escuro';
      case 'en':
        return 'Dark Mode';
      case 'es':
        return 'Modo Oscuro';
      case 'fr':
        return 'Mode Sombre';
      case 'zh':
        return '深色模式';
      case 'ja':
        return 'ダークモード';
      default:
        return 'Dark Mode';
    }
  }

  String get language {
    switch (locale.languageCode) {
      case 'pt':
        return 'Idioma';
      case 'en':
        return 'Language';
      case 'es':
        return 'Idioma';
      case 'fr':
        return 'Langue';
      case 'zh':
        return '语言';
      case 'ja':
        return '言語';
      default:
        return 'Language';
    }
  }

  String get back {
    switch (locale.languageCode) {
      case 'pt':
        return 'Voltar';
      case 'en':
        return 'Back';
      case 'es':
        return 'Volver';
      case 'fr':
        return 'Retour';
      case 'zh':
        return '返回';
      case 'ja':
        return '戻る';
      default:
        return 'Back';
    }
  }

  String get languageChanged {
    switch (locale.languageCode) {
      case 'pt':
        return 'Idioma alterado para';
      case 'en':
        return 'Language changed to';
      case 'es':
        return 'Idioma cambiado a';
      case 'fr':
        return 'Langue changée en';
      case 'zh':
        return '语言已更改为';
      case 'ja':
        return '言語が変更されました';
      default:
        return 'Language changed to';
    }
  }

  String get setAlarm {
    switch (locale.languageCode) {
      case 'pt':
        return 'Definir alarme';
      case 'en':
        return 'Set alarm';
      case 'es':
        return 'Establecer alarma';
      case 'fr':
        return 'Définir alarme';
      case 'zh':
        return '设置闹钟';
      case 'ja':
        return 'アラームを設定';
      default:
        return 'Set alarm';
    }
  }

  String get selectDateTime {
    switch (locale.languageCode) {
      case 'pt':
        return 'Selecionar Data e Hora';
      case 'en':
        return 'Select Date and Time';
      case 'es':
        return 'Seleccionar Fecha y Hora';
      case 'fr':
        return 'Sélectionner Date et Heure';
      case 'zh':
        return '选择日期和时间';
      case 'ja':
        return '日付と時刻を選択';
      default:
        return 'Select Date and Time';
    }
  }

  String get date {
    switch (locale.languageCode) {
      case 'pt':
        return 'Data';
      case 'en':
        return 'Date';
      case 'es':
        return 'Fecha';
      case 'fr':
        return 'Date';
      case 'zh':
        return '日期';
      case 'ja':
        return '日付';
      default:
        return 'Date';
    }
  }

  String get time {
    switch (locale.languageCode) {
      case 'pt':
        return 'Hora';
      case 'en':
        return 'Time';
      case 'es':
        return 'Hora';
      case 'fr':
        return 'Heure';
      case 'zh':
        return '时间';
      case 'ja':
        return '時刻';
      default:
        return 'Time';
    }
  }

  String get clear {
    switch (locale.languageCode) {
      case 'pt':
        return 'Limpar';
      case 'en':
        return 'Clear';
      case 'es':
        return 'Borrar';
      case 'fr':
        return 'Effacer';
      case 'zh':
        return '清除';
      case 'ja':
        return 'クリア';
      default:
        return 'Clear';
    }
  }

  String get futureDateRequired {
    switch (locale.languageCode) {
      case 'pt':
        return 'A data e hora do alarme deve ser futura';
      case 'en':
        return 'Alarm date and time must be in the future';
      case 'es':
        return 'La fecha y hora de la alarma debe ser futura';
      case 'fr':
        return 'La date et l\'heure de l\'alarme doivent être futures';
      case 'zh':
        return '闹钟日期和时间必须是未来的';
      case 'ja':
        return 'アラームの日時は未来でなければなりません';
      default:
        return 'Alarm date and time must be in the future';
    }
  }

  String get taskCompleted {
    switch (locale.languageCode) {
      case 'pt':
        return 'Tarefa concluída';
      case 'en':
        return 'Task completed';
      case 'es':
        return 'Tarea completada';
      case 'fr':
        return 'Tâche terminée';
      case 'zh':
        return '任务已完成';
      case 'ja':
        return 'タスク完了';
      default:
        return 'Task completed';
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['pt', 'en', 'es', 'fr', 'zh', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 