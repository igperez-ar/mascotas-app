import 'dart:convert';
import 'package:equatable/equatable.dart';

AttributeType attributeTypeFromJson(String str) => AttributeType.fromJson(json.decode(str));

String attributeTypeToJson(AttributeType data) => json.encode(data.toJson());

List<AttributeType> mapToAttributeTypeFromJson(List<String> list) => list.map(((String item) => AttributeType.fromJson(json.decode(item) ) ) );


class AttributeType extends Equatable{
  final int id;
  final String name;

  AttributeType({
    this.id,
    this.name,
  });

  AttributeType copyWith({
    String name, 
    String colour, 
  }) {
    return AttributeType(
      id: this.id, 
      name: name ?? this.name, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
  ];

  factory AttributeType.fromJson(Map<String, dynamic> json) => AttributeType(
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
