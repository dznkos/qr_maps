import 'package:flutter/material.dart';
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
      body: _callPage(currentpage),
      bottomNavigationBar: _creaBottomNavigator(),
    );
  }

  Widget _callPage( int indexPage) {
    switch ( indexPage ) {

      case 0: return MapaPage();
      case 1: return DireccionPage();

      default:
        return MapaPage();
    }
  }

  Widget _creaBottomNavigator() {

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
