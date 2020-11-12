import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'models.dart';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

enum PlaceType {
  vet,
  petshop,
}

class Place extends Equatable{
  final int id;
  final String name;
  final PlaceType type;
  final String address;
  final String image;
  final Category category;
  final double lat;
  final double lng;

  Place({
    this.id,
    this.name,
    this.type,
    this.address,
    this.image,
    this.category,
    this.lat,
    this.lng,
  });

  Place copyWith({
    String name, 
    PlaceType type, 
    String address, 
    String image, 
    Category category,
    double lat, 
    double lng
  }) {
    return Place(
      id: this.id, 
      name: name ?? this.name, 
      type: type ?? this.type, 
      address: address ?? this.address, 
      image: image ?? this.image, 
      category: category ?? this.category,
      lat: lat ?? this.lat, 
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    type,
    address,
    image,
    category,
    lat,
    lng,
  ];

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    address: json['address'],
    image: json['image'],
    category: json['category'],
    lat: json['lat'],
    lng: json['lng'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'address': address,
    'image': image,
    'category': category,
    'lat': lat,
    'lng': lng,
  };
}