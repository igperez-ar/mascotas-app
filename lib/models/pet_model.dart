import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

import 'attribute_model.dart';
import 'breed_model.dart';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());


class Pet extends Equatable{
  final int id;
  final String name;
  final String description;
  final List<Media> images;
  final Breed breed;
  final bool inAdoption;
  final DateTime birthDate;
  final String sex;
  final List<Usuario> users;
  /* final List<Attribute> attributes; */

  Pet({
    this.id,
    this.name,
    this.description,
    this.images,
    this.breed,
    this.inAdoption,
    this.birthDate,
    this.sex,
    this.users,
    /* final List<Attribute> attributes; */
  });

  Pet copyWith({
    String name,
    String description,
    List<Media> images,
    Breed breed,
    bool inAdoption,
    DateTime birthDate,
    String sex,
    List<Usuario> users,
    /* List<Attribute> attributes, */
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
      /* attributes: attributes ?? this.attributes */
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
    /* attributes */
  ];

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    breed: Breed.fromJson(json['breed']),
    birthDate: DateTime(json["birthDate"]),
    sex: json['sex'],
    inAdoption: json['inAdoption'],
    users: json["users"],
    /* attributes: json["attributes"] */
    
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "images": images,
    "breed": breed,
    "inAdoption": inAdoption,
    "birthDate": birthDate,
    "sex": sex,
    "users": users,
    /* "attributes": attributes, */
  };
}
