import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class Location extends StatefulWidget {
  final LocationModel location;

  const Location({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  _LocationState createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
  final _markers = <MarkerId, Marker>{};
  final _polylinePoints = PolylinePoints();
  final Map<PolylineId, Polyline> _polyLines = {};
  final List<LatLng> _polylineCoordinates = [];

  GoogleMapController? _mapController;
  CameraPosition _initPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _onLoadMap();
  }

  @override
  void dispose() {
    SVProgressHUD.dismiss();
    _mapController?.dispose();
    super.dispose();
  }

  ///On load map
  void _onLoadMap() {
    final markerId = MarkerId(widget.location.name);
    final position = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );
    final marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: widget.location.name),
    );

    setState(() {
      _initPosition = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 14.4746,
      );
      _markers[markerId] = marker;
    });
    _onLoadDirection();
  }

  ///On load direction
  void _onLoadDirection() async {
    final currentLocation = AppBloc.locationCubit.state;
    if (currentLocation != null) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
      final result = await _polylinePoints.getRouteBetweenCoordinates(
        Application.googleAPI,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(widget.location.latitude, widget.location.longitude),
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        AppBloc.messageCubit.onShow('cannot_direction');
      }
      const id = PolylineId("poly");
      if (!mounted) return;
      final polyline = Polyline(
        polylineId: id,
        color: Theme.of(context).primaryColor,
        points: _polylineCoordinates,
        width: 2,
      );
      setState(() {
        _polyLines[id] = polyline;
      });
      SVProgressHUD.dismiss();
    }
  }

  ///On focus current location
  void _onCurrentLocation() {
    final currentLocation = AppBloc.locationCubit.state;
    if (currentLocation != null) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: _initPosition,
            markers: Set<Marker>.of(_markers.values),
            polylines: Set<Polyline>.of(_polyLines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: SafeArea(
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'directions',
                    mini: true,
                    onPressed: _onLoadDirection,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Icon(
                      Icons.directions,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'location',
                    mini: true,
                    onPressed: _onCurrentLocation,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
