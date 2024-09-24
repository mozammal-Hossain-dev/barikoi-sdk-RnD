import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class SimpleMap extends StatefulWidget {
  const SimpleMap({super.key});

  @override
  State<SimpleMap> createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(23.782238, 90.400945),
    zoom: 12,
  ); //CameraPosition object for initial location in map
  MaplibreMapController? mController;

  static const styleId =
      'osm-liberty'; //barikoi API key, get it from https://developer.barikoi.com
  final mapUrl =
      'https://map.barikoi.com/styles/$styleId/style.json?key=${dotenv.env['API_KEY']}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
        initialCameraPosition:
            initialPosition, // set map initial location where map will show first
        onMapCreated: (MaplibreMapController mapController) {
          //called when map object is created
          mController =
              mapController; // use the MaplibreMapController for map operations
        },
        styleString: mapUrl, // barikoi map style url
      ),
    );
  }
}
