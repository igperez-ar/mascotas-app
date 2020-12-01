import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

Alert alertFromJson(String str) => Alert.fromJson(json.decode(str));

String alertToJson(Alert data) => json.encode(data.toJson());


class Alert extends Equatable{
  final int id;
  final String description;
  final Usuario user;
  final AlertType type;
  final List<Media> images;
  final double lat;
  final double lng;
  final List<Comment> comments;
  final AlertState state;
  final DateTime createdAt;
  final DateTime updatedAt;

  Alert({
    this.id,
    this.description,
    this.user,
    this.type,
    this.images,
    this.lat,
    this.lng,
    this.comments,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  Alert copyWith({
    String description,
    Usuario user,
    AlertType type,
    List<Media> images,
    double lat,
    double lng,
    List<Comment> comments,
    AlertState state,
    DateTime createdAt,
    DateTime updatedAt, 
  }) {
    return Alert(
      id: this.id, 
      description: description ?? this.description,
      user: user ?? this.user,
      type: type ?? this.type,
      images: images ?? this.images,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      comments: comments ?? this.comments,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => [
    id,
    description,
    user,
    type,
    images,
    lat,
    lng,
    comments,
    state,
    createdAt,
    updatedAt,
  ];

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"],
    description: json["description"],
    user: Usuario.fromJson(json["user"]),
    type: AlertType.fromJson(json["type"]),
    images: json["images"].map<Media>((e) => Media.fromJson(e)).toList(),
    lat: json["lat"],
    lng: json["lng"],
    comments: json['comments'].map<Comment>((e) => Comment.fromJson(e)).toList(),
    state: AlertState.fromJson(json["state"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "user": user,
    "type": type,
    "images": jsonEncode(images),
    "lat": lat,
    "lng": lng,
    "comments": jsonEncode(comments),
    "state": state,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  String toString() {
    return this.id.toString();
  }
}
