import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/providers/location_provider.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class AlertsScreen extends StatefulWidget {
  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  bool showMap = false;
  AlertsBloc _alertsBloc;
  LocationProvider _locationProvider = LocationProvider();

  @override
  void initState() {
    super.initState();
    _alertsBloc = BlocProvider.of<AlertsBloc>(context);
  }

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
      body: BlocBuilder<AlertsBloc,AlertsState>(
        builder: (context, state) {

          if (state is AlertsInitial) {
            _alertsBloc.add(FetchAlerts());
          }

          if (state is AlertsFailure) {
            return EmptyWidget(
              title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
              uri: 'assets/images/undraw_server_down.svg',
            );
          }

          if (state is AlertsSuccess) {
            if (state.filteredAlerts.isEmpty) {
              return EmptyWidget(
                title: 'No se encontraron alertas para los filtros seleccionados.',
                uri: 'assets/images/undraw_taken.svg',
              );
            }

            if (!showMap) {
              return RefreshIndicator(
                onRefresh: () async => _alertsBloc.add(FetchAlerts()),
                child: ListView(
                  cacheExtent: 500,
                  padding: EdgeInsets.only(bottom: 20),
                  children: state.alerts.map<AlertWidget>(
                    (alert) => AlertWidget(
                      alert: alert,
                      distance: _locationProvider.getDistance(alert.lat, alert.lng),
                    )
                  ).toList(),
                )
              );

            } else {
              return MapCarousel(
                cards: []
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          ); 
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}