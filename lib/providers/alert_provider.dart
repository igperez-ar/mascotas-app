import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/providers/base_provider.dart';
import 'package:mascotas_app/queries/queries.dart';


class GetAlertsRequestFailure implements Exception {}

class AlertProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.initailizeClient();

  Future<List<Alert>> fetchAlerts() async {
    final result = await _graphQLClient.query(
      QueryOptions(
        documentNode: gql(QueryAlert.getAll),
        fetchPolicy: FetchPolicy.networkOnly
      ),
    );
    
    if (result.hasException) {
      throw GetAlertsRequestFailure();
    }
    
    final data = result.data['urbanAlerts'] as List;

    return data.map((e) => Alert.fromJson(e)).toList();
  }
}