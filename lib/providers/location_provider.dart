import 'package:geolocator/geolocator.dart';


class LocationProvider {
  Position userPosition;

  Future<Position> getCurrentPosition() async {
    if (userPosition == null) {
      Position newPosition = await Geolocator().getCurrentPosition();
      userPosition = newPosition;
    }

    return userPosition;
  }

  Future<String> getDistance(double lat, double lng) async {
    String distance;

    getCurrentPosition();

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
}