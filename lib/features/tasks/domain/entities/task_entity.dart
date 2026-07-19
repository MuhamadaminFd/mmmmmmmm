import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const TaskEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, userId, title, completed];
}
