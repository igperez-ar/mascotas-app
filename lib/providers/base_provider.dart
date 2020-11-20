import 'package:graphql/client.dart';


class BaseProvider {

  static final String url = '127.0.0.1:8000/graphql';

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