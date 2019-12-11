import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import '../provider/db_provider.dart';

class ConectividadBloc {

  //Stream
  final _conectividadController = new BehaviorSubject<ConectividadModel>();
  final _allConectividadController = new BehaviorSubject<List<ConectividadModel>>();
  final _allConnectividadHttpController = new BehaviorSubject<List<ConectividadModel>>();

  //Escuchar 
  Stream<ConectividadModel> get conectividadStream => _conectividadController.stream;
  Stream<List<ConectividadModel>> get allConectividadStream => _allConectividadController.stream;
  Stream<List<ConectividadModel>> get allConectividadHttpStream => _allConnectividadHttpController.stream;
  
  var catalogosProvider = new CatalogoProvider();

  //Insertar Servicios
  Future insertConectividad(ConectividadModel model) async{
    await DBProvider.db.nuevoConectividad(model);
  }

  //Seleccionar Servicios por id
  void selectConectividad(int id) async{
    final conectividad = await DBProvider.db.getConectividadId(id);
    _conectividadController.sink.add(conectividad);
  }

  //Seleccionar Todos los servicios
  void selectAllConectividades() async {
    final conectividad = await DBProvider.db.getAllConectividad();
    _allConectividadController.sink.add(conectividad);
  }

  Future getConectividadHttp() async{
    var conectividades = await catalogosProvider.getConectividades();
    for(var conectividad in conectividades){
      await insertConectividad(conectividad);
    }
  }

  dispose(){
    _conectividadController?.close();
    _allConectividadController?.close();
    _allConnectividadHttpController?.close();
  }



}