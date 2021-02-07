import "dart:convert";
import "package:equatable/equatable.dart";
import "models.dart";

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());


class Review extends Equatable{
  final int id;
  final String description;
  final int score;
  final Usuario user;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    this.id,
    this.description,
    this.score,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  Review copyWith({
    String description, 
    int score, 
    Usuario user, 
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Review(
      id: this.id, 
      description: description ?? this.description, 
      score: score ?? this.score, 
      user: user ?? this.user, 
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => [
    id,
    description,
    score,
    user,
    createdAt,
    updatedAt,
  ];

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    description: json["description"],
    score: json["score"],
    user: Usuario.fromJson(json["user"]),
    createdAt: DateTime.parse(json["createdAt"]), 
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "score": score,
    "user": user,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  String toString() {
    return this.id.toString();
  }
}
