
import 'dart:async';

import 'package:qr_maps/bloc/validator.dart';
import 'package:qr_maps/providers/db_provider.dart';


class ScansBloc with Validators {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //obtener scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }

  obtenerScans() async{
    _scansController.sink.add( await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel newscan) async{
    await DBProvider.db.nuevoScan(newscan);
    obtenerScans();
  }

  borrarScan(int id) async{
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async{
    await DBProvider.db.deleteAllScan();
    obtenerScans();
  }

}

