import 'package:rxdart/rxdart.dart';

import 'package:elavonappmovil/models/totalodts_model.dart';
import 'package:elavonappmovil/provider/odt_provider.dart';

class TotalOdtsBloc{

  //Stream
  final _odtsController = new BehaviorSubject<TotalodtsModel>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _odtsProvider = new OdtProvider();

  //Escuchar Steams
  Stream<TotalodtsModel> get odtsStream => _odtsController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  //Insertar Metodos de Odts
  Future<TotalodtsModel> cargarOdts() async {
    final odts = await _odtsProvider.getTotales();
    //insertar las odts en el stream
    _odtsController.sink.add(odts);
    return odts;
  }

  dispose(){
    _odtsController?.close();
    _cargandoController?.close();
  }

}