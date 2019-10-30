import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:elavonappmovil/models/totalodts_model.dart';

class TotalOdtsBloc{

  //Stream
  final _odtsController = new BehaviorSubject<TotalodtsModel>();
  final _cargandoController = new BehaviorSubject<bool>();

  //Escuchar Steams
  Stream<TotalodtsModel> get odtsStream => _odtsController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  //Insertar Metodos de Odts
  Future<TotalodtsModel> cargarOdts() async {
    final odts = await DBProvider.db.getTotalOdts();
    //insertar las odts en el stream
    _odtsController.sink.add(odts);
    return odts;
  }

  dispose(){
    _odtsController?.close();
    _cargandoController?.close();
  }

}