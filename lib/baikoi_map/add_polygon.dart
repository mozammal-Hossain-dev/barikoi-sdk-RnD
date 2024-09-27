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
      'barikoi-dark'; //barikoi API key, get it from https://developer.barikoi.com
  final mapUrl = 'https://map.barikoi.com/styles/$styleId/style'
      '.json?key=${dotenv.env['API_KEY']}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
        myLocationEnabled: true,
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
              fillOpacity: 0.5,
              draggable: true,
            ),
          );
          mController?.addFill(
            const FillOptions(
              geometry: [
                //geometry of the polygon , in <List<List<LatLng>>> format
                [
                  LatLng(23.80, 90.38354443076582),
                  LatLng(23.82, 90.40521296373265),
                  LatLng(23.81, 90.42285014172887),
                  LatLng(23.86, 90.40050971626783),
                ]
              ],
              fillColor: '#FFA500',
              fillOutlineColor: '#FFA500',
              fillOpacity: 0.5,
              draggable: true,
            ),
          );
          mController?.addFill(
            const FillOptions(
              geometry: [
                //geometry of the polygon , in <List<List<LatLng>>> format
                [
                  LatLng(23.80, 90.4),
                  LatLng(23.82, 90.521296373265),
                  LatLng(23.81, 90.3),
                  LatLng(23.86, 90.1),
                ]
              ],
              fillColor: '#008000',
              fillOutlineColor: '#008000',
              fillOpacity: 0.5,
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
