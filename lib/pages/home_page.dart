import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_maps/pages/direccion_page.dart';
import 'package:qr_maps/pages/mapa_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
         child: Text('QR Scan'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){}
          ),
        ],
      ),
      body: _callPage(currentpage),
      bottomNavigationBar: _crearBottomNavigator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {
    //https://www.youtube.com/watch?v=7gX_mRmCmNE
    //geo:46.9342049662819,13.511148543749965

    var futureString;

    try{
      futureString = await BarcodeScanner.scan();
    } catch (e){
      futureString = e.toString();
    }

    print('Future String: ${futureString.rawContent}');

    if ( futureString != null) {
      print('Tenemos informacion');
    }

  }

  Widget _callPage( int indexPage) {
    switch ( indexPage ) {

      case 0: return MapaPage();
      case 1: return DireccionPage();

      default:
        return MapaPage();
    }
  }

  Widget _crearBottomNavigator() {

    return BottomNavigationBar(
        currentIndex: currentpage,
        onTap: (value) {
          setState(() {
            currentpage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text('Maps')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_size_select_actual),
              title: Text('Qr')
          ),
        ]
    );

  }
}
