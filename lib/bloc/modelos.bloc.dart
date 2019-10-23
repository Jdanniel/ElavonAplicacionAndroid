
import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/db_provider.dart';

class ModelosBloc {

  //Stream
  final _allModeloController = new BehaviorSubject<List<CmodelosModel>>();

  //Escuchar 
  Stream<List<CmodelosModel>> get allModeloStream => _allModeloController.stream;

  final catalogosProvider = new CatalogoProvider();

  //Insertar Servicios
  Future insertModel(CmodelosModel model) async{
    await DBProvider.db.nuevoModelo(model);
  }

  //Seleccionar Servicios por id
  Future<String> selectModelo(int id) async{
    final modelo = await DBProvider.db.getModeloId(id);
    return modelo.descModelo;
  }

  //Seleccionar Todos los servicios
  void selectAllModelos() async {
    final modelo = await DBProvider.db.getAllModelos();
    _allModeloController.sink.add(modelo);
  }

  Future<List<CmodelosModel>> getModelosHttp() async{
    final modelos = await catalogosProvider.getModelos();
    return modelos;
  }

  dispose(){
    _allModeloController?.close();
  }



}