import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_app/bloc/autenticacion/autenticacion_bloc.dart';
/* import 'package:location_permissions/location_permissions.dart'; */

import 'package:mascotas_app/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootScreen extends StatefulWidget {
  @override
  State createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool _showSplash = true;
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    PlacesScreen(),
    AdoptScreen(),
    ProfileScreen(),
    AlertsScreen(),
  ];

  void changeTabIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /* void _locationConfig() async {
    final PermissionStatus permissionStatus = await LocationPermissions().checkPermissionStatus();
    print(permissionStatus);

    final ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
    print(serviceStatus);

    if (permissionStatus != PermissionStatus.granted ||
        permissionStatus != PermissionStatus.restricted) {
      final PermissionStatus newPermissionStatus = await LocationPermissions()
        .requestPermissions(permissionLevel: LocationPermissionLevel.location);
      print(newPermissionStatus);
    }

    if (serviceStatus != ServiceStatus.enabled) {
      final isOpen = await LocationPermissions().openAppSettings();
      print(isOpen);
    }
  } */

  @override
  void initState() {
    super.initState();

    /* this._locationConfig(); */
  }

  Widget _getTabItem(int id, IconData icon, String title) {
    if (_currentIndex == id)
      return IconButton(
        padding: EdgeInsets.zero,
        icon: FaIcon(icon, size: 26, color: Colors.red[300]),
        onPressed: () => this.changeTabIndex(id),
      );

    return IconButton(
      padding: EdgeInsets.zero,
      icon: FaIcon(icon, size: 26, color: Colors.grey[500]),
      onPressed: () => this.changeTabIndex(id),
    );

    return IconButton(
      padding: EdgeInsets.zero,
      icon: Column(children: <Widget>[
        FaIcon(icon, size: 26, color: Colors.grey[600]),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
      ]),
      onPressed: () => this.changeTabIndex(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AutenticacionBloc>(context).clear();
    return BlocBuilder<AutenticacionBloc, AutenticacionState>(
        builder: (context, state) {
          print(state);
      if (state is AutenticacionAuthenticated) {
        return Scaffold(
            body: _children[_currentIndex],
            floatingActionButton: FloatingActionButton(
                onPressed: () => changeTabIndex(4),
                backgroundColor: Colors.red[300],
                child: FaIcon(FontAwesomeIcons.solidBell,
                    size: 26, color: Colors.white)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, -1))
                ]),
                child: BottomAppBar(
                    child: Container(
                      height: 58,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          this._getTabItem(0, FontAwesomeIcons.home, 'Inicio'),
                          this._getTabItem(
                              1, FontAwesomeIcons.mapMarkerAlt, 'Lugares'),
                          SizedBox(width: 40),
                          // Nombre al botón del medio
                          /* Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Alertas', 
                  style: TextStyle(
                    fontSize: 13, 
                    color: Colors.grey[600]
                  )
                )
              ), */
                          this._getTabItem(2, FontAwesomeIcons.paw, 'Adoptar'),
                          this._getTabItem(
                              3, FontAwesomeIcons.userAlt, 'Perfil'),
                        ],
                      ),
                    ),
                    shape:
                        CircularNotchedRectangle())) /* Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0,-1)
              )
            ]
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: changeTabIndex,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).iconTheme.color,
            selectedIconTheme: IconThemeData(size: 32),
            selectedLabelStyle: TextStyle(height: 0),
            
            showSelectedLabels: false,
            elevation: 15,
            unselectedLabelStyle: TextStyle(height: 1.2, fontSize: 13),
            iconSize: 26,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Inicio'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Mapa'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.error),
                title: Text('Alertas'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Perfil'),
              ),
            ],
          ), 
        ), */
            );
      } else {
        return IngresoScreen();
      }
    });
    // if (_showSplash) {
    //   /* return SplashScreen(
    //     onDismiss: () {
    //       changeTabIndex(0);
    //       setState(() {
    //         _showSplash = false;
    //       });
    //     },
    //     onSignup: () {
    //       changeTabIndex(3);
    //       setState(() {
    //         _showSplash = false;
    //       });
    //     } 
    //   ); */
    //   return GestureDetector(
    //       onTap: () => setState(() {
    //             _showSplash = false;
    //           }),
    //       child: IngresoScreen());
    // } else {
    //   return Scaffold(
    //       body: _children[_currentIndex],
    //       floatingActionButton: FloatingActionButton(
    //           onPressed: () => changeTabIndex(4),
    //           backgroundColor: Colors.red[300],
    //           child: FaIcon(FontAwesomeIcons.solidBell,
    //               size: 26, color: Colors.white)),
    //       floatingActionButtonLocation:
    //           FloatingActionButtonLocation.miniCenterDocked,
    //       bottomNavigationBar: Container(
    //           decoration: BoxDecoration(boxShadow: [
    //             BoxShadow(
    //                 color: Colors.black12,
    //                 blurRadius: 10,
    //                 spreadRadius: 2,
    //                 offset: Offset(0, -1))
    //           ]),
    //           child: BottomAppBar(
    //               child: Container(
    //                 height: 58,
    //                 padding: EdgeInsets.symmetric(horizontal: 15),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: <Widget>[
    //                     this._getTabItem(0, FontAwesomeIcons.home, 'Inicio'),
    //                     this._getTabItem(
    //                         1, FontAwesomeIcons.mapMarkerAlt, 'Lugares'),
    //                     SizedBox(width: 40),
    //                     // Nombre al botón del medio
    //                     /* Container(
    //             margin: EdgeInsets.only(top: 20),
    //             child: Text(
    //               'Alertas', 
    //               style: TextStyle(
    //                 fontSize: 13, 
    //                 color: Colors.grey[600]
    //               )
    //             )
    //           ), */
    //                     this._getTabItem(2, FontAwesomeIcons.paw, 'Adoptar'),
    //                     this._getTabItem(3, FontAwesomeIcons.userAlt, 'Perfil'),
    //                   ],
    //                 ),
    //               ),
    //               shape:
    //                   CircularNotchedRectangle())) /* Container(
    //       decoration: BoxDecoration(
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black12.withOpacity(0.05),
    //             blurRadius: 5,
    //             spreadRadius: 1,
    //             offset: Offset(0,-1)
    //           )
    //         ]
    //       ),
    //       child: BottomNavigationBar(
    //         currentIndex: _currentIndex,
    //         onTap: changeTabIndex,
    //         backgroundColor: Theme.of(context).bottomAppBarColor,
    //         type: BottomNavigationBarType.fixed,
    //         selectedItemColor: Theme.of(context).iconTheme.color,
    //         selectedIconTheme: IconThemeData(size: 32),
    //         selectedLabelStyle: TextStyle(height: 0),
            
    //         showSelectedLabels: false,
    //         elevation: 15,
    //         unselectedLabelStyle: TextStyle(height: 1.2, fontSize: 13),
    //         iconSize: 26,
    //         items: <BottomNavigationBarItem>[
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.home),
    //             title: Text('Inicio'),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.map),
    //             title: Text('Mapa'),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.error),
    //             title: Text('Alertas'),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.person),
    //             title: Text('Perfil'),
    //           ),
    //         ],
    //       ), 
    //     ), */
    //       );
    // }
  }
}
