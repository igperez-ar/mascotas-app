import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

import 'attribute_model.dart';
import 'breed_model.dart';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

List<Pet> mapPetsToJson(List<String> items) => items.map((String item) => Pet.fromJson(json.decode(item)));

enum PetSize {
  small
}

enum PetGender {
  male,
  female
}

class Pet extends Equatable{
  final int id;
  final String name;
  final String description;
  final Breed breed;
  final DateTime birthDate;
  final PetGender sex;
  final bool inAdoption;
  final List<Usuario> users;
  final List<Attribute> attributes;

  Pet({
    this.id,
    this.name,
    this.description,
    this.breed,
    this.birthDate,
    this.sex,
    this.inAdoption,
    this.attributes,
    this.users,
  });

  Pet copyWith({
    String name,
    String description,
    String breed,
    DateTime birthDate,
    PetGender sex,
    bool inAdoption,
    List<dynamic> users,
    List<dynamic> attributes
  }) {
    return Pet(
      id: this.id, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      inAdoption: inAdoption ?? this.inAdoption,
      users: users ?? this.users,
      attributes: attributes ?? this.attributes
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    description,
    breed,
    birthDate,
    sex,
    inAdoption,
    users,
    attributes
  ];

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    breed: Breed.fromJson(json['breed']),
    birthDate: new DateTime(json["birthDate"]),
    sex: json['sex'],
    inAdoption: json['inAdoption'],
    users: json["users"],
    attributes: json["attributes"]
    
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'breed': breed,
    
  };
}
