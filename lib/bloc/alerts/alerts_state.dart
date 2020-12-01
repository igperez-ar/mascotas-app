part of 'alerts_bloc.dart';

abstract class AlertsState extends Equatable {
  const AlertsState();

  @override
  List<Object> get props => [];
}

class AlertsInitial extends AlertsState {}

class AlertsFetching extends AlertsState {}

class AlertsSuccess extends AlertsState {
  final List<Alert> alerts;
  final List<Alert> filteredAlerts;

  const AlertsSuccess({
    this.alerts,
    this.filteredAlerts,
  }); 

  @override
  List<Object> get props => [
    alerts,
    filteredAlerts,
  ];
}

class AlertsFailure extends AlertsState {}