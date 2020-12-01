import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());


class Role extends Equatable{
  final int id;
  final String name;

  Role({
    this.id,
    this.name,
  });

  Role copyWith({
    Usuario name,
  }) {
    return Role(
      id: this.id, 
      name: name ?? this.name, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
  ];

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
