import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre_gl/maplibre_gl.dart';

class SymbolMap extends StatefulWidget {
  const SymbolMap({super.key});

  @override
  State<StatefulWidget> createState() => _SymbolMapState();
}

class _SymbolMapState extends State<SymbolMap> {
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(23.782238, 90.400945),
    zoom: 12,
  );
  MaplibreMapController? mController;

  static const styleId = 'osm-liberty'; //barikoi map style id
  final mapUrl = 'https://map.barikoi.com/styles/$styleId/style.'
      'json?key=${dotenv.env['API_KEY']}';
  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      initialCameraPosition: initialPosition,
      styleString: mapUrl,
      onMapCreated: (MaplibreMapController mapController) {
        //called when map object is created
        mController =
            mapController; // use the MaplibreMapController for map operations

        mController?.onSymbolTapped.add(
          _onSymbolTapped,
        ); // add symbol tap event listener to controller
      },
      onStyleLoadedCallback: () {
        // Create SymbolOption for creating a symbol in map
        const symbolOptions = SymbolOptions(
          geometry: LatLng(
            23.835677,
            90.380325,
          ), // location of the symbol, required
          iconImage: 'google', // icon image of the symbol
          //optional parameter to configure the symbol
          iconSize:
              100, // size of the icon in ratio of the actual size, optional
          iconAnchor: 'bottom', // anchor direction of the icon on
          // the location specified,  optional
          textField: 'test', // Text to show on the symbol, optional
          textSize: 12.5,
          textOffset: Offset(
            0,
            1.2,
          ), // shifting the text position relative
          // to the symbol with x,y axis value, optional
          textAnchor: 'bottom', // anchor direction of the text on
          // the location specified, optional
          textColor: '#000000',
          textHaloBlur: 1,
          textHaloColor: '#ffffff',
          textHaloWidth: 0.8,
        );
        addImageFromAsset('custom-marker', 'assets/marker.png').then((value) {
          mController?.addSymbol(symbolOptions);
        });
      },
    );
  }

  void _onSymbolTapped(Symbol symbol) {
    //update symbol text when tapped
    mController?.updateSymbol(
      symbol,
      const SymbolOptions(textField: 'clicked'),
    );
  }

  // Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final bytes = await rootBundle.load(assetName);
    final list = bytes.buffer.asUint8List();
    return mController!.addImage(name, list);
  }

  // Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mController!.addImage(name, response.bodyBytes);
  }
}
