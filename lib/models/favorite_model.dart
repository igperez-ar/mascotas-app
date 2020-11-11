import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:mascotas_app/models/models.dart';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());


class Favorite extends Equatable{
  final int id;
  final Establecimiento tipo;
  final List<String> recuerdos;

  Favorite({
    this.id,
    this.tipo,
    this.recuerdos
  });

  @override
  List<Object> get props => [
    id,
    tipo,
    recuerdos
  ];

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json['id'],
    tipo: Establecimiento.values[json['tipo']],
    recuerdos: jsonDecode(json['recuerdos']).map<String>((e) => e.toString()).toList() 
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'tipo': tipo.index,
    'recuerdos': jsonEncode(recuerdos),
  };
}
