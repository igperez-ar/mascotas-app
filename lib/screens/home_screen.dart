import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EstablecimientosBloc _establecimientoBloc;
  FavoritosBloc _favoritoBloc;
  Position userPosition;

  Future<String> _getDistance(double lat, double lng) async {
    String distance;

    if (userPosition == null) { 
      Position newPosition = await Geolocator().getCurrentPosition();

      if (this.mounted)
        this.setState(() {
          userPosition = newPosition;
        });
    }

    if (userPosition != null) 
      distance = await Geolocator().distanceBetween(
        userPosition.latitude, userPosition.longitude, 
        lat, lng
      ).then((value) {
          if (value.round() >= 1000) 
            return ((value / 1000).toStringAsFixed(1).replaceFirst('.0', '') + ' km de tu ubicación');

          return (value.round().toString().replaceFirst('.0', '') + ' m de tu ubicación'); 
        });

    return distance;
  }

  Widget _getCardList(List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos) {

    return ListView.builder(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      itemCount: max(alojamientos.length, gastronomicos.length), 
      itemBuilder: (context, index) { 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ( index < alojamientos.length 
              ? DefaultCard(
                  type: Establecimiento.alojamiento,
                  establecimiento: alojamientos[index],
                  distance: _getDistance(alojamientos[index].lat, alojamientos[index].lng),
                )
              : Container()
            ),
            ( index < gastronomicos.length 
              ? DefaultCard(
                  type: Establecimiento.gastronomico,
                  establecimiento: gastronomicos[index],
                  distance: _getDistance(gastronomicos[index].lat, gastronomicos[index].lng),
                )
              : Container()
            )
          ]
        ); 
      },
    );
  }

  @override 
  void initState() {
    super.initState();

    _establecimientoBloc = BlocProvider.of<EstablecimientosBloc>(context);
    _favoritoBloc = BlocProvider.of<FavoritosBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio', 
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
                onPressed: () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          /* Container(
            height: 200,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 35, left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage('https://source.unsplash.com/IFxjDdqK_0U/900x400'),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                Text('Tu Mejor', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text('Amigo', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ) */
        ],
      )
      
      /* BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, state) {
          if (state is EstablecimientosInitial) {
            _establecimientoBloc.add(FetchEstablecimientos());
          }

          if (_favoritoBloc.state is FavoritosInitial) {
            _favoritoBloc.add(FetchFavoritos());
          }

          if (state is EstablecimientosFailure) {
            return EmptyWidget(
              title: 'Ocurrió un problema inesperado. Intente nuevamente más tarde.',
              uri: 'assets/images/undraw_server_down.svg',
            );
          }

          if (state is EstablecimientosSuccess) {

            if (state.filteredAlojamientos.isEmpty && 
                state.filteredGastronomicos.isEmpty) {
              return EmptyWidget(
                title: 'No se encontraron establecimientos para los filtros seleccionados.',
                uri: 'assets/images/undraw_taken.svg',
                button: {
                  'title': 'Ir a filtros',
                  'action': () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
                },
              );
            }

            return _getCardList(
              state.filteredAlojamientos, 
              state.filteredGastronomicos
            );
          }
        
          return Center(
            child: CircularProgressIndicator()
          ); 
        }
      ) */
    );
  }
}