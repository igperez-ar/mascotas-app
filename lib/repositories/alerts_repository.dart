import 'dart:async';

import 'package:mascotas_app/providers/providers.dart';
import 'package:mascotas_app/models/models.dart';

class AlertsRepository {
  
  final AlertProvider _provider = AlertProvider();

  Future<List<Alert>> fetchAlerts() async {
    return await _provider.fetchAlerts();
  }
}