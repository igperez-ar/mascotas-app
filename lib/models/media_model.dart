import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mascotas_app/models/models.dart';

Media mediaFromJson(String str) => Media.fromJson(json.decode(str));

String mediaToJson(Media data) => json.encode(data.toJson());


class Media extends Equatable{
  final String url;
  final int order;

  Media({
    this.url,
    this.order,
  });

  Media copyWith({
    String url,
    Usuario order, 
  }) {
    return Media(
      url: url ?? this.url,
      order: order ?? this.order,
    );
  }

  @override
  List<Object> get props => [
    url,
    order,
  ];

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    url: json["image"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "order": order,
  };

  String toString() {
    return this.url;
  }
}
