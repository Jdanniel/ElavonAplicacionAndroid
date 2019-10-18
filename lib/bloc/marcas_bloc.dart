import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/db_provider.dart';

class MarcasBloc {

  //Stream
  final _marcaController = new BehaviorSubject<MarcasModel>();
  final _allMarcaController = new BehaviorSubject<List<MarcasModel>>();
  final _allMarcaHttpController = new BehaviorSubject<List<MarcasModel>>();

  //Escuchar 
  Stream<MarcasModel> get marcaStream => _marcaController.stream;
  Stream<List<MarcasModel>> get allMarcaStream => _allMarcaController.stream;
  Stream<List<MarcasModel>> get allMarcasHttpStream => _allMarcaHttpController.stream;

  var catalogosProvider = new CatalogoProvider();
  
  //Insertar Servicios
  Future insertMarcas(MarcasModel model) async{
    await DBProvider.db.nuevoMarcas(model);
  }

  //Seleccionar Servicios por id
  void selectMarca(int id) async{
    final marca = await DBProvider.db.getMarcasId(id);
    _marcaController.sink.add(marca);
  }

  //Seleccionar Todos los servicios
  void selectAllMarcas() async {
    final marcas = await DBProvider.db.getAllMarcas();
    _allMarcaController.sink.add(marcas);
  }

  Future<List<MarcasModel>> getMarcasHttp() async {
    final marcas = await catalogosProvider.getMarcas();
    return marcas;
  }

  dispose(){
    _marcaController?.close();
    _allMarcaController?.close();
    _allMarcaHttpController?.close();
  }



}