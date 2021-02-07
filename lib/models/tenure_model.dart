import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

Tenure tenureFromJson(String str) => Tenure.fromJson(json.decode(str));

String tenureToJson(Tenure data) => json.encode(data.toJson());


class Tenure extends Equatable{
  final int id;
  final Usuario user;
  final Role role;

  Tenure({
    this.id,
    this.user,
    this.role,
  });

  Tenure copyWith({
    Usuario user,
    Role role,
  }) {
    return Tenure(
      id: this.id, 
      user: user ?? this.user, 
      role: role ?? this.role, 
    );
  }

  @override
  List<Object> get props => [
    id,
    user,
    role,
  ];

  factory Tenure.fromJson(Map<String, dynamic> json) => Tenure(
    id: json['id'],
    user: Usuario.fromJson(json['user']),
    role: Role.fromJson(json['role']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "role": role,
  };
}
