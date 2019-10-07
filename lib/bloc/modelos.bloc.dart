
import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/db_provider.dart';

class ModelosBloc {

  //Stream
  final _modeloController = new BehaviorSubject<CmodelosModel>();
  final _allModeloController = new BehaviorSubject<List<CmodelosModel>>();
  final _allModelHttpController = new BehaviorSubject<List<CmodelosModel>>();

  //Escuchar 
  Stream<CmodelosModel> get modeloStream => _modeloController.stream;
  Stream<List<CmodelosModel>> get allModeloStream => _allModeloController.stream;
  Stream<List<CmodelosModel>> get allModelosStream => _allModelHttpController;  

  final catalogosProvider = new CatalogoProvider();

  //Insertar Servicios
  void insertModel(CmodelosModel model) async{
    await DBProvider.db.nuevoModelo(model);
  }

  //Seleccionar Servicios por id
  void selectModelo(int id) async{
    final modelo = await DBProvider.db.getModeloId(id);
    _modeloController.sink.add(modelo);
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
    _modeloController?.close();
    _allModeloController?.close();
    _allModelHttpController?.close();
  }



}