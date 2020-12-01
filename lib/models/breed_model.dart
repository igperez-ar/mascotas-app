import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/kind_model.dart';

Breed breedFromJson(String str) => Breed.fromJson(json.decode(str));

String breedToJson(Breed data) => json.encode(data.toJson());

class Breed extends Equatable{
  final int id;
  final String name;
  final Kind kind;

  Breed({
    this.id,
    this.name,
    this.kind,
  });

  Breed copyWith({
    String name, 
    Kind kind, 
  }) {
    return Breed(
      id: this.id, 
      name: name ?? this.name, 
      kind: kind ?? this.kind, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    kind,
  ];

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    id: json['id'],
    name: json['name'],
    kind: Kind.fromJson(json['kind']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'kind': kind,
  };

  String toString() {
    return name;
  }
}
