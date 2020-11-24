import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';


class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  int filtered;
  bool showMap = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
                onPressed: () => Navigator.pushNamed(
                  context, '/filtros', 
                  arguments: {
                    'context': context,
                    'favorites': true
                  }
                ),
              );
            }
          ),
          IconButton(
            icon: Icon(showMap ? Icons.format_list_bulleted : Icons.map, size: 30.0,), 
            onPressed: () { 
              setState(() {
                showMap = !showMap;
              });
            } 
          )
        ],
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(QueryPlace.getAll),
        ),
        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            print(result.exception.toString());
            return EmptyWidget(
              title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
              uri: 'assets/images/undraw_server_down.svg',
            );
          }

          if (result.loading) {
            return Center(
              child: CircularProgressIndicator()
            );
          }

          if (result.data == null) {
            return EmptyWidget(
              title: 'No tenemos información para mostrar aquí.',
              uri: 'assets/images/undraw_empty.svg',
            );
          }
                    
          List<Place> places = result.data["places"]
            .map<Place>((e) => Place.fromJson(e))
            .toList();

          if (places.isEmpty) {
            return EmptyWidget(
              title: 'No tenemos información para mostrar aquí.',
              uri: 'assets/images/undraw_empty.svg',
            );
          }

          if (!showMap) {

            return ListView(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
              children: places.map<Widget>(
                (place) => CardWidget(
                  place: place,
                )
              ).toList()
            );
          
          } else {

            return MapCarousel(
              cards: places.map<Widget>(
                (place) => SmallCard(
                  place: place
                )
              ).toList()
            );
          }
        },
      )
    );
  }
}