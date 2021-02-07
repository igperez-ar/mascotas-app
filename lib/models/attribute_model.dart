import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/attribute_type_model.dart';

Attribute attributeFromJson(String str) => Attribute.fromJson(json.decode(str));

String attributeToJson(Attribute data) => json.encode(data.toJson());

List<Attribute> mapToAttributesFromJson(List<String> list) => list.map(((String item) => Attribute.fromJson(json.decode(item) ) ) );

class Attribute extends Equatable{
  final int id;
  final String value;
  final AttributeType attributeType;

  Attribute({
    this.id,
    this.value,
    this.attributeType
  });

  Attribute copyWith({
    String value, 
    String colour, 
  }) {
    return Attribute(
      id: this.id, 
      value: value ?? this.value, 
      attributeType: attributeType ?? this.attributeType
    );
  }

  @override
  List<Object> get props => [
    id,
    value,
    attributeType
  ];

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json['id'],
    value: json['value'],
    attributeType: AttributeType.fromJson(json["type"])
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'attributeType': attributeType
  };

  String toString() {
    return this.value;
  }
}
