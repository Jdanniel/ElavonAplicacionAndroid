import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../provider/db_provider.dart';

class SoftwareBloc {

  //Stream
  final _softwareController = new BehaviorSubject<Softwaremodel>();
  final _allSoftwareController = new BehaviorSubject<List<Softwaremodel>>();
  final _allSoftwareHttpController = new BehaviorSubject<List<Softwaremodel>>();

  //Escuchar 
  Stream<Softwaremodel> get softwareStream => _softwareController.stream;
  Stream<List<Softwaremodel>> get allSoftwareStream => _allSoftwareController.stream;
  Stream<List<Softwaremodel>> get allSoftwareHttpStream => _allSoftwareHttpController.stream;

  var catalogosProvider = new CatalogoProvider();
  
  //Insertar Servicios
  Future insertSoftware(Softwaremodel model) async{
    await DBProvider.db.nuevoSoftware(model);
  }

  //Seleccionar Servicios por id
  void selectSoftware(int id) async{
    final software = await DBProvider.db.getSoftwareId(id);
    _softwareController.sink.add(software);
  }

  //Seleccionar Todos los servicios
  void selectAllConectividades() async {
    final software = await DBProvider.db.getAllSoftware();
    _allSoftwareController.sink.add(software);
  }

  Future getSoftwareHttp() async {
    final softwares = await catalogosProvider.getSoftwares();
    for(var software in softwares){
      await insertSoftware(software);
    }
  }

  dispose(){
    _softwareController?.close();
    _allSoftwareController?.close();
    _allSoftwareHttpController?.close();
  }



}