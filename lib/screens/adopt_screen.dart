import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:mascotas_app/screens/screens.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/card_adopt_widget.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class AdoptScreen extends StatefulWidget {
  @override
  _AdoptScreenState createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {
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

  Widget getWidget(IconData icon, String title, int count) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 15, right: 40),
        margin: EdgeInsets.all(5),
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
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat, size: 25),
            onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.filter_list, size: 30,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
          )
        ],
      ),
      body: /* BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
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

            return  */
                /* Expanded(
                  child:  */ListView(
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
                      DetailSectionWidget(
                        title: 'Categorías',
                        child: Column(
                          children: [
                            Row(
                              children: [
                                getWidget(FontAwesomeIcons.dog, 'Perros', 46),
                                getWidget(FontAwesomeIcons.cat, 'Gatos', 35),
                              ],
                            ),
                            Row(
                              children: [
                                getWidget(FontAwesomeIcons.crow, 'Aves', 20),
                                getWidget(FontAwesomeIcons.question, 'Otros', 30),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      DetailSectionWidget(
                        title: 'Mis adopciones',
                        child: Container(
                          height: 260,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/wFbkj9ilGnQ/800x600',
                                name: 'Firulais',
                                age: '6 años',
                                species: 'Perro',
                                gender: 'Macho',
                                breed: 'Border Collie',
                                colors: [Colors.orange[800], Colors.grey[100]]
                              ),
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/gM4Oq1iH4fE/800x600',
                                name: 'Pelusa',
                                age: '8 meses',
                                species: 'Gato',
                                gender: 'Hembra',
                                breed: 'Mixto',
                                colors: [Colors.grey[100]]
                              ), 
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DetailSectionWidget(
                        title: 'Nuevas mascotas',
                        child: Container(
                          height: 260,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/1_nDj7Rwm8Y/1100x1200',
                                name: 'Kelly',
                                age: '4 años',
                                species: 'Gato',
                                gender: 'Hembra',
                                breed: 'Mixto',
                                colors: [Colors.orange[800], Colors.brown, Colors.grey[100]]
                              ),
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/mx0DEnfYxic/1100x1200',
                                name: 'Rocky',
                                age: '5 años',
                                species: 'Perro',
                                gender: 'Macho',
                                breed: 'Border Collie',
                                colors: [Colors.black, Colors.grey[100]]
                              ),
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/wFbkj9ilGnQ/800x600',
                                name: 'Firulais',
                                age: '6 años',
                                species: 'Perro',
                                gender: 'Macho',
                                breed: 'Border Collie',
                                colors: [Colors.orange[800], Colors.grey[100]]
                              ),
                              CardAdoptWidget(
                                image: 'https://source.unsplash.com/gM4Oq1iH4fE/800x600',
                                name: 'Pelusa',
                                age: '8 meses',
                                species: 'Gato',
                                gender: 'Hembra',
                                breed: 'Mixto',
                                colors: [Colors.grey[100]]
                              ), 
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                
    );
          /* }
          
        
          return Center(
            child: CircularProgressIndicator()
          ); 
        }
      )
    ); */
  }
}