import "dart:convert";
import "package:equatable/equatable.dart";
import 'package:mascotas_app/models/pet_model.dart';
import 'package:mascotas_app/providers/base_provider.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

List<Usuario> mapUsuariosFromJson(List<Map<String, dynamic>> list) => list.map((item) => Usuario.fromJson(item));

class Usuario extends Equatable{
  final int id;
  final String email;
  final String name;
  final String image;
  final List<dynamic> pets;

  Usuario({
    this.id,
    this.email,
    this.name,
    this.image,
    this.pets,
  });

  Usuario copyWith({
    String email, 
    String name,
    String image, 
    List<dynamic> pets,
  }) {
    return Usuario(
      id: this.id, 
      email: email ?? this.email, 
      name: name ?? this.name, 
      image: image ?? this.image,
      pets: pets ?? this.pets
    );
  }

  @override
  List<Object> get props => [
    id,
    email,
    name,
    image,
    pets
  ];

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    image: BaseProvider.mediaURL+json["image"],
    pets: json["pets"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "image": image,
    "pets": pets,
  };

  String toString() {
    return this.email;
  }
}
