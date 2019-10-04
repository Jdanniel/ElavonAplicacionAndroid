import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../provider/db_provider.dart';
import 'package:elavonappmovil/models/unidades_model.dart';

class UnidadesBloc {

  //Stream
  final _unidadController = new BehaviorSubject<UnidadesModel>();
  final _allunidadesController = new BehaviorSubject<List<UnidadesModel>>();
  final _allunidadesHttpController = new BehaviorSubject<List<UnidadesModel>>();

  //Escuchar 
  Stream<UnidadesModel> get unidadesStream => _unidadController.stream;
  Stream<List<UnidadesModel>> get allUnidadesStream => _allunidadesController.stream;
  Stream<List<UnidadesModel>> get allUnidadesHttpStream => _allunidadesHttpController.stream;

  var catalogosProvider = new CatalogoProvider();
  
  //Insertar Servicios
  void insertUnidad(UnidadesModel model) async{
    final unidad = DBProvider.db.nuevoUnidad(model);
    _unidadController.sink.add(unidad);
  }

  //Seleccionar Servicios por id
  void selectUnidad(int id) async{
    final unidad = await DBProvider.db.getUnidadId(id);
    _unidadController.sink.add(unidad);
  }

  //Seleccionar Todos los servicios
  void selectAllUnidades() async {
    final unidades = await DBProvider.db.getAllUnidades();
    _allunidadesController.sink.add(unidades);
  }

  Future<List<UnidadesModel>> getUnidadesHttp() async {
    final unidades = await catalogosProvider.getUnidades();
    _allunidadesHttpController.sink.add(unidades);
    return unidades;
  }

  dispose(){
    _unidadController?.close();
    _allunidadesController?.close();
  }



}