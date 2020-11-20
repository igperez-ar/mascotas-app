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

  Future<Usuario> getOne(String username) async {
    return await _provider.getOne(username);
  }

  Future<Usuario> addUsuario(String email, String password, name) async {
    return await _provider.addUsuario(email, password, name);
  }

  Future<Usuario> updateUsuario(String email, Usuario newUser) async {
    return await _provider.updateUsuario(email, newUser);
  }
}