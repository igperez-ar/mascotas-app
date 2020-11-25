import 'dart:convert';
import 'package:equatable/equatable.dart';

Kind kindFromJson(String str) => Kind.fromJson(json.decode(str));

String kindToJson(Kind data) => json.encode(data.toJson());


class Kind extends Equatable{
  final int id;
  final String name;

  Kind({
    this.id,
    this.name,
  });

  Kind copyWith({
    String name, 
    String colour, 
  }) {
    return Kind(
      id: this.id, 
      name: name ?? this.name, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
  ];

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  String toString() {
    return this.name;
  }
}
