import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode;
  ConfiguracionBloc _configuracionBloc;

  @override 
  void initState() {
    super.initState();

    _configuracionBloc = BlocProvider.of<ConfiguracionBloc>(context);
  }

  Widget _getOption({IconData icon, String title, Function onPress, bool value}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon),
                SizedBox(width: 15),
                Text(title, style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                  )
                )
              ],
            ),
            value == null 
            ? IconButton(
                icon: Icon(Icons.chevron_right), 
                onPressed: onPress
              )
            : Switch(
              value: value, 
              onChanged: (value) => onPress()
            )
          ],
        )
      )
    );
  }

  Widget _getOptionsGroup(List<Widget> options) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2, 2)
          )
        ]
      ),
      child: Column(
        children: options.map<Widget>((element) {
          if (options.indexOf(element) != 0)
            return Column(
              children: <Widget>[
                Divider(indent: 20, endIndent: 20, thickness: 1),
                element
              ],
            );

          return element;
        }).toList()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
   
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      }, 
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {
          if (state is AutenticacionAuthenticated) {
            Usuario usuario = state.usuario;

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(usuario.username, 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.red[300],
                actions: <Widget>[
                  /* IconButton(
                    icon: Icon(Icons.favorite_border), 
                    onPressed: () => Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen()
                      )
                    ),
                  ), */
                  IconButton(
                    icon: Icon(Icons.notifications), 
                    onPressed: () {}
                  )
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    width: _width,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment(0, 0.5),
                        colors: [Colors.red[300], Colors.red[200]])
                    ),
                  ),
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 15),
                            child: ProfileImage(
                              image: usuario.foto, 
                              size: ProfileImageSize.big
                            ),
                          ),
                          Text(usuario.nombre, 
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black38,
                                  blurRadius: 3,
                                  offset: Offset(1.5, 1.5)
                                )
                              ]
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                            child: (usuario.descripcion != null 
                              ? Text(usuario.descripcion, 
                                  style: TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        blurRadius: 2,
                                        offset: Offset(1.3, 1.3)
                                      )
                                    ]
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Container()
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      DetailSectionWidget(
                        title: 'Mascotas',
                        actions: [
                          {'icon': Icons.more_horiz, 'on_press': null}
                        ],
                        child: Row(
                          children: [
                            Container(
                              height: 130,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage('https://source.unsplash.com/AllEP6K_TAg/1200x1300'),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('Olivia',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                      /* DetailSectionWidget(
                        title: 'Galería', 
                        child: 
                      ), */
                      /* _getOptionsGroup([
                        _getOption(
                          icon: Icons.pets,
                          title: "Mascotas",
                          onPress: () {}
                        ),
                        _getOption(
                          icon: Icons.group,
                          title: "Cuenta",
                          onPress: () => Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen()
                            )
                          )
                        ),
                      ]), */
                      /* BlocBuilder<ConfiguracionBloc, ConfiguracionState>(
                        builder: (context, state) {
                          if (state is ConfiguracionSuccess) {
                            darkMode = state.config['dark-mode'];
                          }
                        
                          return _getOptionsGroup([
                            _getOption(
                              icon: Icons.notifications,
                              title: "Notificaciones",
                              onPress: () {}
                            ),
                            _getOption(
                              icon: Icons.devices,
                              title: "Dispositivos",
                              onPress: () {}
                            ),
                            _getOption(
                              icon: Icons.chat_bubble,
                              title: "Idioma",
                              onPress: () {}
                            ),
                            _getOption(
                              icon: Icons.lightbulb_outline,
                              title: "Modo oscuro",
                              value: darkMode, 
                              onPress: () {
                                setState(() {
                                  darkMode = !darkMode;
                                });
                                _configuracionBloc.add(UpdateConfiguracion({'dark-mode': darkMode}));
                              }
                            ),
                          ]);
                        }
                      ) */
                    ],
                  )
                ],
              )
            );
        }

        return IngresoScreen();
        },
      )
    );
  } 
  
}