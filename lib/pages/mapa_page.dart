import 'package:flutter/material.dart';

import 'package:flutter_map/plugin_api.dart';
import 'package:qr_maps/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLagLng(), 15.0);
              },
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {

    return new FlutterMap(
        mapController: map,
        options: MapOptions(
          center: scan.getLagLng(),
          minZoom: 17
        ),
        layers: [
          _crearMapa(),
          _crearMarcador( scan ),
        ],
    );
  }

   _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiYm9tYmVyc3RhY2siLCJhIjoiY2tmYzF5ZTVsMWJlMzJycWcwN3k5czY5bCJ9.guw8c5Gsb3HCZtj95tGhrQ',
        'id': 'mapbox.mapbox-$tipoMapa-v7'
      }
    );
  }

  _crearMarcador(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLagLng(),
          builder: (context) => Container(
            color: Colors.grey,
            child: Icon(
              Icons.location_on,
              size: 65,
              color: Theme.of(context).primaryColor,
              ),
          ),
        )
      ]
    );

  }

  Widget _crearBotonFlotante(BuildContext context) {

    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {

          if( tipoMapa == 'streets'){
            tipoMapa = 'dark';
          } else if (tipoMapa == 'dark'){
            tipoMapa = 'light';
          } else if (tipoMapa == 'light'){
            tipoMapa = 'outdoors';
          } else if (tipoMapa == 'outdoors'){
            tipoMapa = 'satellite';
          } else{
            tipoMapa = 'streets';
          }

          setState(() {});

        },
    );
  }
}
