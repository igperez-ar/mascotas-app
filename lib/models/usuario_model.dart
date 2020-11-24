import "dart:convert";
import "package:equatable/equatable.dart";

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario extends Equatable{
  final int id;
  final String email;
  final String name;
  final String image;

  Usuario({
    this.id,
    this.email,
    this.name,
    this.image,
  });

  Usuario copyWith({
    String email, 
    String name,
    String image, 
  }) {
    return Usuario(
      id: this.id, 
      email: email ?? this.email, 
      name: name ?? this.name, 
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [
    id,
    email,
    name,
    image
  ];

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "image": image,
  };

  String toString() {
    return this.email;
  }
}
