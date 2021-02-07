import 'dart:convert';
import 'package:equatable/equatable.dart';


Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category extends Equatable{
  final int id;
  final String name;
  final int value;

  Category({
    this.id,
    this.name,
    this.value,
  });

  @override
  List<Object> get props => [
    id,
    name,
    value,
  ];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'value': value,
  };
}
