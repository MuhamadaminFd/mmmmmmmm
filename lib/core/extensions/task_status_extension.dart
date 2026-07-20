import 'package:flutter/material.dart';

class TaskStatus {
  final String title;
  final Color color;
  final IconData icon;

  TaskStatus({
    required this.title,
    required this.color,
    required this.icon,
  });
}

extension TaskStatusExtension on bool {
  static TaskStatus fromBool(bool completed) {
    return completed
        ? TaskStatus(
            title: 'Выполнено',
            color: Colors.green,
            icon: Icons.check_circle,
          )
        : TaskStatus(
            title: 'В процессе',
            color: Colors.orange,
            icon: Icons.schedule,
          );
  }
}
