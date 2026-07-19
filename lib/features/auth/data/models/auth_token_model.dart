import 'dart:convert';
import 'package:equatable/equatable.dart';

class AuthTokenModel extends Equatable {
  final String token;
  final DateTime createdAt;
  final bool isValid;

  const AuthTokenModel({
    required this.token,
    required this.createdAt,
    this.isValid = true,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isValid: json['isValid'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'createdAt': createdAt.toIso8601String(),
      'isValid': isValid,
    };
  }

  @override
  List<Object?> get props => [token, createdAt, isValid];
}
