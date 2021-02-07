import 'dart:ui';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/repositories/repository.dart';
import 'package:mascotas_app/screens/pet/create_screen.dart';
import 'package:mascotas_app/widgets/pet_widget.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UsuarioRepository _usuarioRepository = new UsuarioRepository();
  Usuario _usuario;


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Mi cuenta",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red[300],
        actions: <Widget>[
          /* IconButton(
            icon: Icon(Icons.favorite_border), 
            onPressed: () => Navigator.push(context
              MaterialPageRoute(
                builder: (context) => FavoritesScreen()
              )
            ),
          ), 
          IconButton(
            icon: Icon(Icons.notifications), 
            onPressed: () {}
          ) */
        ],
      ),
      body: BlocBuilder<AutenticacionBloc, AutenticacionState>(
        builder: (context, state) {

          if (state is AutenticacionAuthenticated) {

            return FutureBuilder(
              future: _usuarioRepository.getUser(state.usuario.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.hasError) {
                  return EmptyWidget(
                    title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
                    uri: 'assets/images/undraw_server_down.svg',
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                Usuario _usuario = snapshot.data;

                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: _width,
                          height: 220,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment(0, 0.5),
                              colors: [Colors.red[300], Colors.red[200]]
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 15),
                              child: ProfileImage(
                                image: _usuario.image,
                                size: ProfileImageSize.big
                              ),
                            ),
                            Text(
                              _usuario.name,
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    blurRadius: 3,
                                    offset: Offset(1.5, 1.5)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(_usuario.email,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          SizedBox(height: 20),
                          DetailSectionWidget(
                            title: 'Mascotas',
                            actions: [
                              {
                                'icon': Icons.add, 
                                'onPressed': () => Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => CreatePetScreen()
                                    )
                                  )
                              }
                            ],
                            child: Container(
                              height:  _width * 0.6,
                              child: (_usuario.pets.isNotEmpty
                                ? ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: _usuario.pets.map<Widget>((item) {
                                      return PetWidget(
                                        pet: item
                                      );
                                    }).toList(),
                                  )
                                : Container(
                                    width: _width,
                                    child: DashedContainer(
                                      dashColor: Colors.grey[500], 
                                      strokeWidth: 2,
                                      dashedLength: 11,
                                      blankLength: 10,
                                      borderRadius: 20,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 60),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.pets, size: 50, color: Colors.grey[600],),
                                            Padding(padding: EdgeInsets.only(top: 10)),
                                            Text('aún no cargaste ninguna mascota'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }
}
