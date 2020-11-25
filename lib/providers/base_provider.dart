import 'package:graphql/client.dart';


class BaseProvider {

  static final String url = '192.168.1.34:8000/graphql';
  static final String mediaURL = 'http://192.168.1.34:8000/media/';

  static final HttpLink httpLink = HttpLink(
    uri: 'http://$url',
  );

  static final WebSocketLink webSocketLink = WebSocketLink(
    url: 'ws://$url',
    config: SocketClientConfig(
      autoReconnect: true,
    ),
  );

  static final Link link = httpLink.concat(webSocketLink);

  static GraphQLClient initailizeClient() {
    return GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
  }
}