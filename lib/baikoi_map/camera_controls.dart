import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class CameraControl extends StatefulWidget {
  const CameraControl({super.key});

  @override
  State<CameraControl> createState() => _CameraControlState();
}

class _CameraControlState extends State<CameraControl> {
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(23.835677, 90.380325),
    zoom: 12,
  ); //CameraPosition object for initial location in map
  MaplibreMapController? mController;

  static const styleId =
      'osm-liberty'; //barikoi API key, get it from https://developer.barikoi.com
  final mapUrl = 'https://map.barikoi.com/styles/$styleId/style.'
      'json?key=${dotenv.env['API_KEY']}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
          initialCameraPosition: initialPosition, // set map initial location
          // where map will show first
          onMapCreated: (MaplibreMapController mapController) {
            //called when
            // map object is created
            mController = mapController; // use the MaplibreMapController
            // for map operations
          },
          styleString: mapUrl, // barikoi map style url
          onStyleLoadedCallback: () {
            //implement any of the functions below to test different kind of
            // camera controls, here newCameraPosition function is implemented
            _setCameraPosition(mController);
          }),
    );
  }
}

void _setCameraPosition(MaplibreMapController? mController) {
  //set new CameraPostion for map
  mController?.animateCamera(CameraUpdate.newCameraPosition(
    const CameraPosition(
      bearing: 270, //bearing of the map view, value range 0- 360
      target:
          LatLng(23.3160895, 90.81294527), // LatLng position of the location
      tilt: 30, // tilt the map by degree
      zoom: 17, // zoom level of the map
    ),
  ));
}

void _setNewLatlng(MaplibreMapController? mController) {
  //animate camera to the Latlng position
  mController
      ?.animateCamera(
        CameraUpdate.newLatLng(
          const LatLng(23.824775, 90.360954), // LatLng position of the location
        ),
        duration: const Duration(seconds: 3), // map camera animation duration
      )
      .then((result) =>
          debugPrint("mController?.animateCamera() returned $result"));
}

void _setNewLatlngZoom(MaplibreMapController? mController) {
  //animate camera to the Latlng position with zoom level
  mController?.animateCamera(
    CameraUpdate.newLatLngZoom(const LatLng(23.774506, 90.444063), 7),
    duration: const Duration(milliseconds: 300),
  );
}

void _setlatlngBounds(MaplibreMapController? mController) {
  mController?.animateCamera(
    CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: const LatLng(23.878921, 90.345552),
          northeast: const LatLng(23.736799, 90.451606),
        ),
        left: 10, // padding in 4 directions
        top: 5,
        bottom: 25,
        right: 10),
  );
}

void _scrollby(MaplibreMapController? mController) {
  //scroll the map programatically in x and y axis
  mController?.animateCamera(
    CameraUpdate.scrollBy(
      150,
      -225,
    ),
  );
}

void _zoomBy(MaplibreMapController? mController) {
  //zoom in/out the map in current position, negative values for zoom out , positive for zoom in
  mController?.animateCamera(
    CameraUpdate.zoomBy(-0.5),
  );
}
