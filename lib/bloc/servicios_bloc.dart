import 'package:rxdart/rxdart.dart';
import '../provider/db_provider.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';

class ServiciosBloc {

  //Stream
  final _servicioHttpController = new BehaviorSubject<List<ServiciosModel>>();
  final _servicioController = new BehaviorSubject<ServiciosModel>();
  final _allServicioController = new BehaviorSubject<List<ServiciosModel>>();

  //Escuchar 
  Stream<ServiciosModel> get servicioStream => _servicioController.stream;
  Stream<List<ServiciosModel>> get allServicioStream => _allServicioController.stream;
  Stream<List<ServiciosModel>> get allServicioHttpStream => _servicioHttpController.stream;

  final catalogosProvider = CatalogoProvider();
  
  //Insertar Servicios
  Future insertServicios(ServiciosModel model) async{
    await DBProvider.db.nuevoServicio(model);
  }

  //Seleccionar Servicios por id
  void selectServicio(int id) async{
    final servicio = await DBProvider.db.getServicioId(id);
    _servicioController.sink.add(servicio);
  }

  //Seleccionar Todos los servicios
  void selectAllServicios() async {
    final servicio = await DBProvider.db.getAllServicio();
    _allServicioController.sink.add(servicio);
  }

  //Seleccionar Servicios via Http
  Future<List<ServiciosModel>> getServiciosHttp() async{
    final servicios = await catalogosProvider.getServicios();
    return servicios;
  }

  dispose(){
    _servicioController?.close();
    _allServicioController?.close();
    _servicioHttpController?.close();
  }



}