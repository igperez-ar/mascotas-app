import 'dart:convert';
import 'package:equatable/equatable.dart';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

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
  final String breed;
  final List<String> colors;
  final List<String> images;
  final PetSize size;
  final DateTime birthdate;
  final PetGender gender;
  final bool sterilized;

  Pet({
    this.id,
    this.name,
    this.description,
    this.breed,
    this.colors,
    this.images,
    this.size,
    this.birthdate,
    this.gender,
    this.sterilized,
  });

  Pet copyWith({
    String name,
    String description,
    String breed,
    List<String> colors,
    List<String> images,
    PetSize size,
    DateTime birthdate,
    PetGender gender,
    bool sterilized
  }) {
    return Pet(
      id: this.id, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      breed: breed ?? this.breed,
      colors: colors ?? this.colors,
      images: images ?? this.images, 
      size: size ?? this.size, 
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender, 
      sterilized: sterilized ?? this.sterilized, 
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    description,
    breed,
    colors,
    images,
    size,
    birthdate,
    gender,
    sterilized,
  ];

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    breed: json['breed'],
    colors: json['colors'],
    images: json['images'],
    size: json['size'],
    birthdate: json['birthdate'],
    gender: json['gender'],
    sterilized: json['sterilized'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'breed': breed,
    'colors': colors,
    'images': images,
    'size': size,
    'birthdate': birthdate,
    'gender': gender,
    'sterilized': sterilized,
  };
}
