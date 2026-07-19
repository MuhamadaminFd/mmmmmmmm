import 'package:flutter/material.dart';

enum TaskStatus {
  completed,
  pending,
}

extension TaskStatusExtension on TaskStatus {
  String get title {
    switch (this) {
      case TaskStatus.completed:
        return 'Выполнено';
      case TaskStatus.pending:
        return 'В процессе';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.pending:
        return Colors.orange;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskStatus.completed:
        return Icons.check_circle;
      case TaskStatus.pending:
        return Icons.schedule;
    }
  }

  static TaskStatus fromBool(bool isCompleted) {
    return isCompleted ? TaskStatus.completed : TaskStatus.pending;
  }

  bool toBoolean() {
    return this == TaskStatus.completed;
  }
}
