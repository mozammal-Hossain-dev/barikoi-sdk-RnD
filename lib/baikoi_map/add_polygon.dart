import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class FillMap extends StatefulWidget {
  const FillMap({super.key});

  @override
  State<FillMap> createState() => _FillMapState();
}

class _FillMapState extends State<FillMap> {
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(23.835677, 90.380325),
    zoom: 12,
  ); //CameraPosition object for initial location in map
  MaplibreMapController? mController;

  static const styleId =
      'osm-liberty'; //barikoi API key, get it from https://developer.barikoi.com
  final mapUrl = 'https://map.barikoi.com/styles/$styleId/style'
      '.json?key=${dotenv.env['API_KEY']}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
        initialCameraPosition:
            initialPosition, // set map initial location where map will show
        // first
        onMapCreated: (MaplibreMapController mapController) {
          //called when map object is created
          mController = mapController; // use the MaplibreMapController for map
          // operations
        },
        styleString: mapUrl, // barikoi map style url
        onStyleLoadedCallback: () {
          //add polygon to map
          mController?.addFill(
            const FillOptions(
              geometry: [
                //geometry of the polygon , in <List<List<LatLng>>> format
                [
                  LatLng(23.85574361143307, 90.38354443076582),
                  LatLng(23.823632508626005, 90.40521296373265),
                  LatLng(23.82639837105691, 90.42285014172887),
                  LatLng(23.86204198543561, 90.40050971626783),
                ]
              ],
              fillColor: '#FF0000',
              fillOutlineColor: '#FFFFFF',
              fillOpacity: 1,
              draggable: true,
            ),
          );
          mController?.addFill(
            const FillOptions(
              geometry: [
                //geometry of the polygon , in <List<List<LatLng>>> format
                [
                  LatLng(22.85574361143307, 90.38354443076582),
                  LatLng(22.823632508626005, 90.40521296373265),
                  LatLng(22.82639837105691, 90.42285014172887),
                  LatLng(22.86204198543561, 90.40050971626783),
                ]
              ],
              fillColor: '#FF0000',
              fillOutlineColor: '#FFFFFF',
              fillOpacity: 1,
              draggable: true,
            ),
          );
          //add Fill tap event listener
          mController?.onFillTapped.add(_OnFillTapped);
        },
      ),
    );
  }

  void _OnFillTapped(Fill argument) {
    // implement polygon fill tap event here
  }
}
