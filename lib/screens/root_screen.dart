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
    /* BlocProvider.of<AutenticacionBloc>(context).clear(); */
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
  }

  @override
  Widget build(BuildContext context) {

    if (_showSplash) {
      return SplashScreen(
        time: Duration(seconds: 4),
        onFinish: () => setState(() {
          _showSplash = false;
        })
      );
    }

    return BlocBuilder<AutenticacionBloc, AutenticacionState>(
      builder: (context, state) {

        if (state is AutenticacionAuthenticated) {
          return Scaffold(
            body: _children[_currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () => changeTabIndex(4),
              backgroundColor: Colors.red[300],
              child: FaIcon(FontAwesomeIcons.solidBell,
                size: 26, 
                color: Colors.white
              )
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -1)
                  )
                ]
              ),
              child: BottomAppBar(
                child: Container(
                  height: 58,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      this._getTabItem(0, FontAwesomeIcons.home, 'Inicio'),
                      this._getTabItem(1, FontAwesomeIcons.mapMarkerAlt, 'Lugares'),
                      SizedBox(width: 40),
                      this._getTabItem(2, FontAwesomeIcons.paw, 'Adoptar'),
                      this._getTabItem(3, FontAwesomeIcons.userAlt, 'Perfil'),
                    ],
                  ),
                ),
                shape: CircularNotchedRectangle()
              )
            )
          );
      } else {
        return IngresoScreen();
      }
    });
  }
}
