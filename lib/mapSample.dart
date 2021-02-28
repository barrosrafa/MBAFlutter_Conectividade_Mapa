import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aula2_conectividade/geopoint.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatelessWidget {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Geopoint geopoint = ModalRoute.of(context).settings.arguments;

    debugPrint("${geopoint.latitude}");
    debugPrint("${geopoint.longitude}");

    CameraPosition initial = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(geopoint.latitude, geopoint.longitude),
        tilt: 59.440717697143555,
        zoom: 15.151926040649414);

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

}