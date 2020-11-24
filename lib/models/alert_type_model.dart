import 'dart:convert';
import 'package:equatable/equatable.dart';

AlertType alertTypeFromJson(String str) => AlertType.fromJson(json.decode(str));

String alertTypeToJson(AlertType data) => json.encode(data.toJson());


class AlertType extends Equatable{
  final int id;
  final String name;
  final String colour;

  AlertType({
    this.id,
    this.name,
    this.colour,
  });

  AlertType copyWith({
    String name, 
    String colour, 
  }) {
    return AlertType(
      id: this.id, 
      name: name ?? this.name, 
      colour: colour ?? this.colour, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    colour,
  ];

  factory AlertType.fromJson(Map<String, dynamic> json) => AlertType(
    id: json['id'],
    name: json['name'],
    colour: json['colour'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'colour': colour,
  };

  String toString() {
    return this.name;
  }
}
