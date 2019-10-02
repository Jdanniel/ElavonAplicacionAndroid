import 'package:rxdart/rxdart.dart';

import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/provider/odt_provider.dart';

class OdtsBloc{

  //Stream
  final _odtsController = new BehaviorSubject<List<Odtmodel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _odtsProvider = new OdtProvider();

  //Escuchar Steams
  Stream<List<Odtmodel>> get odtsStream => _odtsController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  //Insertar Metodos de Odts
  void cargarOdts() async {
    final odts = await _odtsProvider.getOdts();
    //insertar las odts en el stream
    _odtsController.sink.add(odts);
  }

  dispose(){
    _odtsController?.close();
    _cargandoController?.close();
  }

}