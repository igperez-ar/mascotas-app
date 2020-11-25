import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/providers/base_provider.dart';
import 'package:mascotas_app/queries/queries.dart';

class GetUsuariosRequestFailure implements Exception {}

class UsuarioProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.initailizeClient();

  Future<Usuario> getOne(String username) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        documentNode: gql(QueryUsuario.getOne),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          'username': username
        }
      ),
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    final data = result.data['usuarios'] as List;
    
    if (data.isEmpty)
      return null;

    return Usuario.fromJson(data.first);
  }

  Future<dynamic> authenticate(String email, String password) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryUsuario.authenticate),
        variables: {
          'email': email,
          'password': password,
        },
      )
    );
    
    return result.data['tokenAuth'];
  }

  Future<dynamic> register(String email, String password, String name) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryUsuario.register),
        variables: {
          'email': email,
          'password': password,
          'name': name
        }
      )
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    ;
    return result.data['userRegister'];
  }

  Future<dynamic> getInfo(int id) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        documentNode: gql(QueryUsuario.getInfo),
        variables: {
          "id": id
        }
      )
    );
    return result.data['user'];
  }

  /* Future<Usuario> updateUsuario(String email, Usuario newUser) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryUsuario.updateUsuario),
        variables: {
          'oldEmail': email,
          'name': newUser.name,
          'image': newUser.image,
          'email': newUser.email,
          'password': newUser.password,
        }
      )
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    
    final data = result.data['update_usuarios']['returning'] as List;
    return Usuario.fromJson(data.first);
  } */
}