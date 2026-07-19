import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  @override
  List<Object?> get props => [id, userId, title, completed];
}
