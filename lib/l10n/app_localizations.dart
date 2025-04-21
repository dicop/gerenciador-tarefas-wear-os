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
    Locale('hi', 'IN'),
    Locale('ar', 'SA'),
    Locale('bn', 'BD'),
    Locale('ru', 'RU'),
    Locale('pa', 'IN'),
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
      case 'hi':
        return 'कार्य प्रबंधक';
      case 'ar':
        return 'مدير المهام';
      case 'bn':
        return 'টাস্ক ম্যানেজার';
      case 'ru':
        return 'Менеджер задач';
      case 'pa':
        return 'ਟਾਸਕ ਮੈਨੇਜਰ';
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
      case 'hi':
        return 'कार्य जोड़ें';
      case 'ar':
        return 'إضافة مهمة';
      case 'bn':
        return 'টাস্ক যোগ করুন';
      case 'ru':
        return 'Добавить задачу';
      case 'pa':
        return 'ਟਾਸਕ ਜੋੜੋ';
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
      case 'hi':
        return 'कार्य संपादित करें';
      case 'ar':
        return 'تعديل المهمة';
      case 'bn':
        return 'টাস্ক সম্পাদনা করুন';
      case 'ru':
        return 'Редактировать задачу';
      case 'pa':
        return 'ਟਾਸਕ ਸੰਪਾਦਿਤ ਕਰੋ';
      default:
        return 'Edit Task';
    }
  }

  String get taskName {
    switch (locale.languageCode) {
      case 'pt':
        return 'Nome';
      case 'en':
        return 'Name';
      case 'es':
        return 'Nombre';
      case 'fr':
        return 'Nom';
      case 'zh':
        return '名称';
      case 'ja':
        return '名前';
      case 'hi':
        return 'नाम';
      case 'ar':
        return 'الاسم';
      case 'bn':
        return 'নাম';
      case 'ru':
        return 'Имя';
      case 'pa':
        return 'ਨਾਮ';
      default:
        return 'Name';
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
      case 'hi':
        return 'विवरण';
      case 'ar':
        return 'الوصف';
      case 'bn':
        return 'বিবরণ';
      case 'ru':
        return 'Описание';
      case 'pa':
        return 'ਵੇਰਵਾ';
      default:
        return 'Description';
    }
  }

  String get alarmDateTime {
    switch (locale.languageCode) {
      case 'pt':
        return 'Alarme';
      case 'en':
        return 'Alarm';
      case 'es':
        return 'Alarma';
      case 'fr':
        return 'Alarme';
      case 'zh':
        return '闹钟';
      case 'ja':
        return 'アラーム';
      case 'hi':
        return 'अलार्म';
      case 'ar':
        return 'المنبه';
      case 'bn':
        return 'অ্যালার্ম';
      case 'ru':
        return 'Будильник';
      case 'pa':
        return 'ਅਲਾਰਮ';
      default:
        return 'Alarm';
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
      case 'hi':
        return 'सहेजें';
      case 'ar':
        return 'حفظ';
      case 'bn':
        return 'সংরক্ষণ করুন';
      case 'ru':
        return 'Сохранить';
      case 'pa':
        return 'ਸੰਭਾਲੋ';
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
      case 'hi':
        return 'हटाएं';
      case 'ar':
        return 'حذف';
      case 'bn':
        return 'মুছে ফেলুন';
      case 'ru':
        return 'Удалить';
      case 'pa':
        return 'ਮਿਟਾਓ';
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
      case 'hi':
        return 'हटाने की पुष्टि करें';
      case 'ar':
        return 'تأكيد الحذف';
      case 'bn':
        return 'মুছে ফেলার নিশ্চিত করুন';
      case 'ru':
        return 'Подтвердить удаление';
      case 'pa':
        return 'ਮਿਟਾਉਣ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';
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
      case 'hi':
        return 'क्या आप वाकई इस कार्य को हटाना चाहते हैं?';
      case 'ar':
        return 'هل أنت متأكد أنك تريد حذف هذه المهمة؟';
      case 'bn':
        return 'আপনি কি নিশ্চিত যে আপনি এই টাস্কটি মুছে ফেলতে চান?';
      case 'ru':
        return 'Вы уверены, что хотите удалить эту задачу?';
      case 'pa':
        return 'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ ਤੇ ਇਸ ਟਾਸਕ ਨੂੰ ਮਿਟਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ?';
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
      case 'hi':
        return 'पूर्णता की पुष्टि करें';
      case 'ar':
        return 'تأكيد الإكمال';
      case 'bn':
        return 'সম্পূর্ণতা নিশ্চিত করুন';
      case 'ru':
        return 'Подтвердить завершение';
      case 'pa':
        return 'ਪੂਰਤਾ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';
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
      case 'hi':
        return 'क्या आप इस कार्य को पूर्ण के रूप में चिह्नित करना चाहते हैं?';
      case 'ar':
        return 'هل تريد تحديد هذه المهمة كمكتملة؟';
      case 'bn':
        return 'আপনি কি এই টাস্কটি সম্পূর্ণ হিসেবে চিহ্নিত করতে চান?';
      case 'ru':
        return 'Вы хотите отметить эту задачу как выполненную?';
      case 'pa':
        return 'ਕੀ ਤੁਸੀਂ ਇਸ ਟਾਸਕ ਨੂੰ ਪੂਰਾ ਕੀਤੇ ਹੋਏ ਵਜੋਂ ਚਿੰਨ੍ਹਿਤ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?';
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
      case 'hi':
        return 'रद्द करें';
      case 'ar':
        return 'إلغاء';
      case 'bn':
        return 'বাতিল করুন';
      case 'ru':
        return 'Отмена';
      case 'pa':
        return 'ਰੱਦ ਕਰੋ';
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
      case 'hi':
        return 'पुष्टि करें';
      case 'ar':
        return 'تأكيد';
      case 'bn':
        return 'নিশ্চিত করুন';
      case 'ru':
        return 'Подтвердить';
      case 'pa':
        return 'ਪੁਸ਼ਟੀ ਕਰੋ';
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
      case 'hi':
        return 'सेटिंग्स';
      case 'ar':
        return 'الإعدادات';
      case 'bn':
        return 'সেটিংস';
      case 'ru':
        return 'Настройки';
      case 'pa':
        return 'ਸੈਟਿੰਗਾਂ';
      default:
        return 'Settings';
    }
  }

  String get tasks {
    switch (locale.languageCode) {
      case 'pt':
        return 'Tarefas';
      case 'en':
        return 'Tasks';
      case 'es':
        return 'Tareas';
      case 'fr':
        return 'Tâches';
      case 'zh':
        return '任务';
      case 'ja':
        return 'タスク';
      case 'hi':
        return 'कार्य';
      case 'ar':
        return 'المهام';
      case 'bn':
        return 'টাস্ক';
      case 'ru':
        return 'Задачи';
      case 'pa':
        return 'ਟਾਸਕ';
      default:
        return 'Tasks';
    }
  }

  String get task {
    switch (locale.languageCode) {
      case 'pt':
        return 'Tarefa';
      case 'en':
        return 'Task';
      case 'es':
        return 'Tarea';
      case 'fr':
        return 'Tâche';
      case 'zh':
        return '任务';
      case 'ja':
        return 'タスク';
      case 'hi':
        return 'कार्य';
      case 'ar':
        return 'مهمة';
      case 'bn':
        return 'টাস্ক';
      case 'ru':
        return 'Задача';
      case 'pa':
        return 'ਟਾਸਕ';
      default:
        return 'Task';
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
      case 'hi':
        return 'थीम';
      case 'ar':
        return 'المظهر';
      case 'bn':
        return 'থিম';
      case 'ru':
        return 'Тема';
      case 'pa':
        return 'ਥੀਮ';
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
      case 'hi':
        return 'डार्क मोड';
      case 'ar':
        return 'الوضع الداكن';
      case 'bn':
        return 'ডার্ক মোড';
      case 'ru':
        return 'Темный режим';
      case 'pa':
        return 'ਡਾਰਕ ਮੋਡ';
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
      case 'hi':
        return 'भाषा';
      case 'ar':
        return 'اللغة';
      case 'bn':
        return 'ভাষা';
      case 'ru':
        return 'Язык';
      case 'pa':
        return 'ਭਾਸ਼ਾ';
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
      case 'hi':
        return 'वापस';
      case 'ar':
        return 'رجوع';
      case 'bn':
        return 'পিছনে';
      case 'ru':
        return 'Назад';
      case 'pa':
        return 'ਵਾਪਸ';
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
      case 'hi':
        return 'भाषा बदलकर';
      case 'ar':
        return 'تم تغيير اللغة إلى';
      case 'bn':
        return 'ভাষা পরিবর্তন করা হয়েছে';
      case 'ru':
        return 'Язык изменен на';
      case 'pa':
        return 'ਭਾਸ਼ਾ ਬਦਲ ਕੇ';
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
      case 'hi':
        return 'अलार्म सेट करें';
      case 'ar':
        return 'ضبط المنبه';
      case 'bn':
        return 'অ্যালার্ম সেট করুন';
      case 'ru':
        return 'Установить будильник';
      case 'pa':
        return 'ਅਲਾਰਮ ਸੈੱਟ ਕਰੋ';
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
      case 'hi':
        return 'दिनांक और समय चुनें';
      case 'ar':
        return 'اختر التاريخ والوقت';
      case 'bn':
        return 'তারিখ এবং সময় নির্বাচন করুন';
      case 'ru':
        return 'Выберите дату и время';
      case 'pa':
        return 'ਤਾਰੀਖ ਅਤੇ ਸਮਾਂ ਚੁਣੋ';
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
      case 'hi':
        return 'तारीख';
      case 'ar':
        return 'التاريخ';
      case 'bn':
        return 'তারিখ';
      case 'ru':
        return 'Дата';
      case 'pa':
        return 'ਤਾਰੀਖ';
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
      case 'hi':
        return 'समय';
      case 'ar':
        return 'الوقت';
      case 'bn':
        return 'সময়';
      case 'ru':
        return 'Время';
      case 'pa':
        return 'ਸਮਾਂ';
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
      case 'hi':
        return 'साफ़ करें';
      case 'ar':
        return 'مسح';
      case 'bn':
        return 'মুছে ফেলুন';
      case 'ru':
        return 'Очистить';
      case 'pa':
        return 'ਸਾਫ਼ ਕਰੋ';
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
      case 'hi':
        return 'अलार्म की तारीख और समय भविष्य में होना चाहिए';
      case 'ar':
        return 'يجب أن يكون تاريخ ووقت المنبه في المستقبل';
      case 'bn':
        return 'অ্যালার্মের তারিখ এবং সময় ভবিষ্যতে হতে হবে';
      case 'ru':
        return 'Дата и время будильника должны быть в будущем';
      case 'pa':
        return 'ਅਲਾਰਮ ਦੀ ਤਾਰੀਖ ਅਤੇ ਸਮਾਂ ਭਵਿੱਖ ਵਿੱਚ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ';
      default:
        return 'Alarm date and time must be in the future';
    }
  }

  String get taskCompleted {
    switch (locale.languageCode) {
      case 'pt':
        return 'Concluída';
      case 'en':
        return 'Completed';
      case 'es':
        return 'Completada';
      case 'fr':
        return 'Terminée';
      case 'zh':
        return '已完成';
      case 'ja':
        return '完了';
      case 'hi':
        return 'पूर्ण';
      case 'ar':
        return 'مكتمل';
      case 'bn':
        return 'সম্পূর্ণ';
      case 'ru':
        return 'Завершено';
      case 'pa':
        return 'ਪੂਰਾ ਹੋਇਆ';
      default:
        return 'Completed';
    }
  }

  String get noTasks {
    switch (locale.languageCode) {
      case 'pt':
        return 'Sem tarefas';
      case 'en':
        return 'No tasks';
      case 'es':
        return 'Sin tareas';
      case 'fr':
        return 'Aucune tâche';
      case 'zh':
        return '没有任务';
      case 'ja':
        return 'タスクなし';
      case 'hi':
        return 'कोई कार्य नहीं';
      case 'ar':
        return 'لا توجد مهام';
      case 'bn':
        return 'কোন টাস্ক নেই';
      case 'ru':
        return 'Нет задач';
      case 'pa':
        return 'ਕੋਈ ਟਾਸਕ ਨਹੀਂ';
      default:
        return 'No tasks';
    }
  }

  String get taskNameRequired {
    switch (locale.languageCode) {
      case 'pt':
        return 'O nome da tarefa é obrigatório';
      case 'en':
        return 'Task name is required';
      case 'es':
        return 'El nombre de la tarea es obligatorio';
      case 'fr':
        return 'Le nom de la tâche est obligatoire';
      case 'zh':
        return '任务名称是必填项';
      case 'ja':
        return 'タスク名は必須です';
      case 'hi':
        return 'कार्य का नाम आवश्यक है';
      case 'ar':
        return 'اسم المهمة مطلوب';
      case 'bn':
        return 'টাস্কের নাম প্রয়োজন';
      case 'ru':
        return 'Название задачи обязательно';
      case 'pa':
        return 'ਟਾਸਕ ਦਾ ਨਾਮ ਜ਼ਰੂਰੀ ਹੈ';
      default:
        return 'Task name is required';
    }
  }

  String get taskDescriptionRequired {
    switch (locale.languageCode) {
      case 'pt':
        return 'A descrição da tarefa é obrigatória';
      case 'en':
        return 'Task description is required';
      case 'es':
        return 'La descripción de la tarea es obligatoria';
      case 'fr':
        return 'La description de la tâche est obligatoire';
      case 'zh':
        return '任务描述是必填项';
      case 'ja':
        return 'タスクの説明は必須です';
      case 'hi':
        return 'कार्य का विवरण आवश्यक है';
      case 'ar':
        return 'وصف المهمة مطلوب';
      case 'bn':
        return 'টাস্কের বিবরণ প্রয়োজন';
      case 'ru':
        return 'Описание задачи обязательно';
      case 'pa':
        return 'ਟਾਸਕ ਦਾ ਵੇਰਵਾ ਜ਼ਰੂਰੀ ਹੈ';
      default:
        return 'Task description is required';
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['pt', 'en', 'es', 'fr', 'zh', 'ja', 'hi', 'ar', 'bn', 'ru', 'pa'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 