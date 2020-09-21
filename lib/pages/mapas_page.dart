
import 'package:flutter/material.dart';
import 'package:qr_maps/bloc/scans_bloc.dart';
import 'package:qr_maps/models/scan_model.dart';

import 'package:qr_maps/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final scansBloc = new ScansBloc();

    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStream,
        builder: (BuildContext context,AsyncSnapshot<List<ScanModel>> snapshot) {

          if ( !snapshot.hasData ){
            return Center(child: CircularProgressIndicator(),);
          }

          final scans = snapshot.data;

          if ( scans.length == 0){
            return Center(child: Text('no hay informacion'));
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) => Dismissible(
                key:  UniqueKey(),
                background: Container(color: Colors.red,),
                onDismissed: (direction) {
                  scansBloc.borrarScan(scans[i].id);
                },
                child: ListTile(
                  leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
                  title: Text(scans[i].valor),
                  subtitle: Text('id: ${scans[i].id}'),
                  trailing: Icon( Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor,),
                  onTap: () => utils.abrirScan(context, scans[i])
                ),
              ),

          );

        },
    );
  }
}
