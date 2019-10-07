import 'package:elavonappmovil/models/updates_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class UpdatesBloc{

  final _updatesController = new BehaviorSubject<UpdatesModel>();

  var catalogoProvider = new CatalogoProvider();

  //Insertar Servicios
  void insertUpdates(UpdatesModel model) async{
    await DBProvider.db.nuevoUpdate(model);
  }

  //Seleccionar
  Future<UpdatesModel> selectUpdate() async{
    final updates = await DBProvider.db.getLastUpdate();
    _updatesController.sink.add(updates);
    return updates;
  }  

  dispose(){
    _updatesController?.close();
  }

}