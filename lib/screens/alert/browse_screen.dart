import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class AlertsScreen extends StatefulWidget {
  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  bool showMap = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Alertas",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30,),
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => CreateAlertScreen()
              )
            ),
          ),
          IconButton(
            icon: Icon(showMap ? Icons.format_list_bulleted : Icons.map, size: 25,),
            onPressed: () => setState(() { showMap = !showMap; })
          ),
          IconButton(
            icon: Icon(Icons.filter_list, size: 30,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
          ),
        ],
      ),
      body: Builder(
        builder: (context) {

          /* if (estState is EstablecimientosFailure) {
            return EmptyWidget(
              title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
              uri: 'assets/images/undraw_server_down.svg',
            );
          } */

          /* if (estState is EstablecimientosSuccess) { */
            /* if (EMPTY) {
              return EmptyWidget(
                title: 'No se encontraron favorites para los filtros seleccionados.',
                uri: 'assets/images/undraw_taken.svg',
              );
            } */

            if (!showMap) {
              return ListView(
                padding: EdgeInsets.only(bottom: 20),
                children: [
                  AlertWidget(),
                  AlertWidget(),
                  AlertWidget(),
                ],
              );

            } else {
              return MapCarousel(
                cards: []
              );
            }
        /* } else { 
            return Center(
              child: CircularProgressIndicator(),
            );
              ); 
          } */
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}