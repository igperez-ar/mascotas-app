import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/repositories/repository.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  final AlertsRepository repository;

  AlertsBloc({@required this.repository}) : super(AlertsInitial());

  Stream<AlertsState> mapEventToState(
    AlertsEvent event
  ) async* {

    if (event is FetchAlerts) {
      yield* _mapAlertsLoadedToState();
    } else if (event is UpdateFilteredAlerts) {
      yield* _mapAlertsFilteredToState(event);
    }
  }

  Stream<AlertsState> _mapAlertsLoadedToState() async* {
    yield AlertsFetching();

    try {
      final List<Alert> alerts = await repository.fetchAlerts();
      
      alerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      yield AlertsSuccess(
        alerts: alerts,
        filteredAlerts: alerts,
      );

    } catch (e) {
      print(e);
      yield AlertsFailure();
    }
  }

  Stream<AlertsState> _mapAlertsFilteredToState(
    UpdateFilteredAlerts event
  ) async* {

    if (state is AlertsSuccess) {
      final successState = (state as AlertsSuccess);

      yield AlertsSuccess(
        alerts: successState.alerts,
        filteredAlerts: [],
      );
    }
  }
}
