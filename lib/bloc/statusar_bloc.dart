

import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class StatusArBloc{

  CatalogoProvider _catalogoProvider = new CatalogoProvider();

  Future getAllStatusArHttp() async {
    final statusars = await _catalogoProvider.getStatusAr();
    for(var statusar in statusars){
      await DBProvider.db.nuevoStatusAr(statusar);
    }
  }

  Future getStatusArById(int id) async {
    final status = await DBProvider.db.getStatusArId(id);
    return status;
  }

}