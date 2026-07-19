import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';

abstract class TasksRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskDetail(int id);
  Future<TaskModel> updateTask(int id, bool completed);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  TasksRemoteDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/todos'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((task) => TaskModel.fromJson(task as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<TaskModel> getTaskDetail(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/todos/$id'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        return TaskModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load task detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<TaskModel> updateTask(int id, bool completed) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/todos/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'completed': completed}),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        return TaskModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
