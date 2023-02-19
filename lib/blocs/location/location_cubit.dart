import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<Position?> {
  StreamSubscription<Position>? positionStream;

  LocationCubit() : super(null);

  ///Request permission
  Future<bool> _requestPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  ///Cubit start location services
  void onLocationService() async {
    final permission = await _requestPermission();
    if (permission) {
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen((Position? position) {
        if (position != null) {
          emit(position);
        }
      });
    }
  }
}
