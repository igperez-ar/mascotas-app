import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());


class Comment extends Equatable{
  final int id;
  final String content;
  final Usuario user;

  Comment({
    this.id,
    this.content,
    this.user,
  });

  Comment copyWith({
    String content,
    Usuario user,
  }) {
    return Comment(
      id: this.id, 
      content: content ?? this.content,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
    id,
    content,
    user,
  ];

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    content: json["content"],
    user: Usuario.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "user": user,
  };

  String toString() {
    return this.id.toString();
  }
}
