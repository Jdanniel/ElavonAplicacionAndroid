
import 'package:elavonappmovil/models/bdcambiostatusar_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class CambioStatusArBloc{

  CatalogoProvider _catalogoProvider = new CatalogoProvider();

  Future getAllCambiosStatusArHttp() async {
    final cambios = await _catalogoProvider.getcambioStatusAr();
    for(var cambio in cambios){
      await DBProvider.db.nuevoCambioStatusAr(cambio);
    }
  }

  Future<BdCambioStatusArModel> getCambioStatusArById(int id) async {
    final cambio = await DBProvider.db.getCambioStatusArId(id);
    return cambio;
  }

}