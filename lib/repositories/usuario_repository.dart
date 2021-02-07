import 'dart:async';

import 'package:mascotas_app/providers/providers.dart';
import 'package:mascotas_app/models/models.dart';

class UsuarioRepository {
  
  final UsuarioProvider _provider = UsuarioProvider();


  Future<Map<String, dynamic>> authenticate(String email, String password) async {
    /* Se obtienen los datos de la mutation y se devuelven en un Map para su retorno al BLoC */  
    var response = await _provider.authenticate(email, password);
    String token = response['token'];
    Usuario user = Usuario.fromJson(response['user']);

    return { "token": token, "user": user };
  }

  Future<Usuario> getUser(int id) async {
    var response = await _provider.getInfo(id);
    Usuario user = Usuario.fromJson(response);

    return user;
  }

  Future<int> addUsuario(String email, String password, String name) async {
    var response = await _provider.register(email, password, name);
    int userId = response['user']['id'];
    return userId;
  }

  /* Future<Usuario> updateUsuario(String email, Usuario newUser) async {
    return await _provider.updateUsuario(email, newUser);
  } */
}