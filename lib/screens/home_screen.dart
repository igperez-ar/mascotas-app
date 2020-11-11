import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
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
  /* EstablecimientosBloc _establecimientoBloc;
  FavoriteBloc _favoriteBloc; */
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

  /* Widget _getCardList(List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos) {

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
  } */
  Widget _buildCarousel() {

    return CarouselSlider(
        items: [
          Container(
            height: 45,
            color: Colors.red
          ),
          Container(
            height: 45,
            color: Colors.blue
          ),
          Container(
            height: 45,
            color: Colors.green
          ),
        ],/* widget.cards.map((e) => Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: e,
          ) 
        ).toList(), */
        options: CarouselOptions(
          height: 210,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          initialPage: 0
        ),
    );
  }

  Widget _buildCategory(String title, IconData icon) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.red[300],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white)
          ),
          Text(title)
        ],
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
          SizedBox(height: 15),
          DetailSectionWidget(
            title: "Destacados", 
            child: _buildCarousel()
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategory(
                "Popular",
                Icons.add,
              ),
              _buildCategory(
                "Tiendas",
                Icons.add,
              ),
              _buildCategory(
                "Belleza",
                Icons.add,
              ),
              _buildCategory(
                "Adopción",
                Icons.add,
              ),
            ],
          ),
          SizedBox(height: 40),
          DetailSectionWidget(
            title: "Cerca de tu ubicación", 
            child: Container(
              height: 320,
              child: ListView(
                padding: EdgeInsets.only(bottom: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  AlertWidget(
                    compact: true,
                  ),
                  AlertWidget(
                    compact: true,
                  ),
                ],
              ),
            )
          )
        ],
      )
      
      /* BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, state) {
          if (state is EstablecimientosInitial) {
            _establecimientoBloc.add(FetchEstablecimientos());
          }

          if (_favoriteBloc.state is FavoritesInitial) {
            _favoriteBloc.add(FetchFavorites());
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