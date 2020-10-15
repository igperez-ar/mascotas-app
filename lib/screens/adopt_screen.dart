import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:mascotas_app/screens/screens.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class AdoptScreen extends StatefulWidget {
  @override
  _AdoptScreenState createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {
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

  Widget getWidget(IconData icon, String title, int count) {
    return /* Flexible(
      child:  */Container(
        height: 70,
        width: 170,
        padding: EdgeInsets.only(left: 15, right: 40),
        /* margin: EdgeInsets.only(right: 20), */
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
      );
    /* ),*/
  }

  Widget _getPet(String image, String name, String age, String ageMsg, String gender, String breed, List colors) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => PetShowScreen(
            image: image,
            name: name,
            age: age,
            gender: gender,
            breed: breed,
            colors: colors
          )
        )
      ),
      child: Container(
        width: 180,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1)
            )
          ]
        ),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      Icon(Icons.favorite_border)  
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('$ageMsg $age',
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
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
        /* title: Text('Adoptar', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ), */
        backgroundColor: Colors.red[300],
        elevation: 0,
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.filter_list, color: Colors.grey[50], size: 30.0,), 
                onPressed: () => Navigator.pushNamed(context, '/filtros', arguments: {'context': context})
              );
            },
          )
        ],
      ),
      body: /* BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
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

            return  */Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  color: Colors.red[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adopta un', 
                        style: TextStyle(
                          color: Colors.grey[50],
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('Amigo', 
                        style: TextStyle(
                          color: Colors.grey[50],
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: SearchBar(words: []),
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                ),
                Expanded(
                  child: ListView(
                    children: [
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
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: DetailSectionWidget(
                          title: 'Categorías',
                          child: /* Container(
                            height: 70,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [ */
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: [
                                    getWidget(FontAwesomeIcons.dog, 'Perros', 46),
                                    getWidget(FontAwesomeIcons.cat, 'Gatos', 35),
                                    getWidget(FontAwesomeIcons.crow, 'Aves', 20),
                                    getWidget(FontAwesomeIcons.question, 'Otros', 30),
                                  ],
                                ),
                              /* ],
                            ),*/
                          ), 
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: DetailSectionWidget(
                          title: 'Nuevas mascotas',
                          child: Container(
                            height: 260,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _getPet(
                                  'https://source.unsplash.com/1_nDj7Rwm8Y/1100x1200',
                                  'Kelly',
                                  '4 años',
                                  'Gato de',
                                  'Hembra',
                                  'Mixto',
                                  [Colors.orange[800], Colors.brown, Colors.grey[100]]
                                ),
                                _getPet(
                                  'https://source.unsplash.com/mx0DEnfYxic/1100x1200',
                                  'Rocky',
                                  '5 años',
                                  'Perro de',
                                  'Macho',
                                  'Border Collie',
                                  [Colors.black, Colors.grey[100]]
                                ),
                                _getPet(
                                  'https://source.unsplash.com/wFbkj9ilGnQ/800x600',
                                  'Firulais',
                                  '6 años',
                                  'Perro de',
                                  'Macho',
                                  'Border Collie',
                                  [Colors.orange[800], Colors.grey[100]]
                                ),
                                _getPet(
                                  'https://source.unsplash.com/gM4Oq1iH4fE/800x600',
                                  'Pelusa',
                                  '8 meses',
                                  'Gatito de',
                                  'Hembra',
                                  'Mixto',
                                  [Colors.grey[100]]
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  )
                ),
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