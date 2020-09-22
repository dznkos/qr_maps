import 'dart:io';

import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_maps/bloc/scans_bloc.dart';
import 'package:qr_maps/models/scan_model.dart';

import 'package:qr_maps/pages/direccion_page.dart';
import 'package:qr_maps/pages/mapas_page.dart';

import 'package:qr_maps/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = ScansBloc();

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
              onPressed: (){
                scansBloc.borrarScanTodos();
              }
          ),
        ],
      ),
      body: _callPage(currentpage),
      bottomNavigationBar: _crearBottomNavigator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: () =>_scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    //https://www.youtube.com/watch?v=7gX_mRmCmNE
    //geo:46.9342049662819,13.511148543749965

    var futureString = 'https://pub.dev';

    /*try{
      futureString = await BarcodeScanner.scan();
    } catch (e){
      futureString = e.toString();
    }

    print('Future String: ${futureString.rawContent}');

    */
    if ( futureString != null) {

      final scan = ScanModel( valor: futureString);
      scansBloc.agregarScan(scan);

      final scan2 = ScanModel( valor: 'geo:46.9342049662819,13.511148543749965');
      scansBloc.agregarScan(scan2);

      if ( Platform.isIOS ){
        Future.delayed( Duration( milliseconds: 750), (){
          utils.abrirScan(context,scan);
        });
      }

      /*utils.abrirScan(scan);*/

    }

  }

  Widget _callPage( int indexPage) {
    switch ( indexPage ) {

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
        return MapasPage();
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
