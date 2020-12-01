import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/screens/screens.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/pet_widget.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class AdoptScreen extends StatefulWidget {
  @override
  _AdoptScreenState createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {

  Widget getWidget(IconData icon, String title, int count) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 15, right: 40),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[300], width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red[300].withOpacity(0.3),
                shape: BoxShape.circle
              ),
              child: FaIcon(icon),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5),
                Text('$count de 78',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600]
                  ),
                )
              ],
            )
          ],
        )
      )
    );
  }

  @override 
  void initState() {
    super.initState();

    /* _establecimientoBloc = BlocProvider.of<EstablecimientosBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context); */
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Adopción",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        /* actions: [
          IconButton(
            icon: Icon(Icons.filter_list, size: 30,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
          )
        ], */
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(QueryPet.allAdoptions),
        ),
        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {

          if (result.hasException) {
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
              title: 'No hay información para mostrar aquí.',
              uri: 'assets/images/undraw_empty.svg',
            );
          }

          List<Pet> _pets = result.data["petsInAdoption"].map<Pet>((e) => Pet.fromJson(e)).toList();

          /* if (state.filteredAlerts.isEmpty) {
            return EmptyWidget(
              title: 'No se encontraron alertas para los filtros seleccionados.',
              uri: 'assets/images/undraw_taken.svg',
            );
          }  */

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 30),
              SearchBar(words: [], hintText: "Encuentra a tu mascota favorita",),
              SizedBox(height: 30),
              /* Container(
                /* padding: EdgeInsets.only(top: 20), */
                decoration: BoxDecoration(
                  color: Colors.red[300],
                ),
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 10),
                    borderRadius: BorderRadius.vertical( 
                      top: Radius.circular(50)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5), */
              /* DetailSectionWidget(
                title: 'Categorías',
                child: Column(
                  children: [
                    Row(
                      children: [
                        getWidget(FontAwesomeIcons.dog, 'Perros', 46),
                        getWidget(FontAwesomeIcons.cat, 'Gatos', 35),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        getWidget(FontAwesomeIcons.crow, 'Aves', 20),
                        getWidget(FontAwesomeIcons.question, 'Otros', 30),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), */
              /* DetailSectionWidget(
                title: 'Mis adopciones',
                child: Container(
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), */
              DetailSectionWidget(
                title: 'Mascotas',
                child: Container(
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _pets.map<Widget>(
                      (e) => PetWidget(pet: e)
                    ).toList(),
                  ),
                ),
              )
            ],
          );
        }
      )
    );
  }
}