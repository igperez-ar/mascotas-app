import 'dart:convert';
import 'package:equatable/equatable.dart';

AlertState alertStateFromJson(String str) => AlertState.fromJson(json.decode(str));

String alertStateToJson(AlertState data) => json.encode(data.toJson());


class AlertState extends Equatable{
  final int id;
  final String name;

  AlertState({
    this.id,
    this.name,
  });

  AlertState copyWith({
    String name,
  }) {
    return AlertState(
      id: this.id, 
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
  ];

  factory AlertState.fromJson(Map<String, dynamic> json) => AlertState(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  String toString() {
    return this.name;
  }
}
