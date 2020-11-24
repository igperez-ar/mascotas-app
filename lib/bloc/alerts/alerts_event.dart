part of 'alerts_bloc.dart';

abstract class AlertsEvent extends Equatable {
  const AlertsEvent();
}

class FetchAlerts extends AlertsEvent {
  const FetchAlerts();

  @override
  List<Object> get props => [];
}

class UpdateFilteredAlerts extends AlertsEvent {
  /* final List<Alojamiento> newFilteredAlojamientos;
  final List<Gastronomico> newFilteredGastronomicos; */

  const UpdateFilteredAlerts(
    /* this.newFilteredAlojamientos,
    this.newFilteredGastronomicos */
  );

  @override
  List<Object> get props => [
    /* this.newFilteredAlojamientos,
    this.newFilteredGastronomicos */
  ];
}
