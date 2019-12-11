
import 'package:elavonappmovil/models/ccausas_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class CausasBloc{

  final _catalogoProvider = new CatalogoProvider();

  Future ingresarCausa(CCausasModel model) async {
    await DBProvider.db.nuevaCausa(model);
  }

  Future<CCausasModel> getCausa(int idcausa) async{
    final ress = await DBProvider.db.getCausas(idcausa);
    return ress;
  }

  Future<List<CCausasModel>> getAllCausas()async{
    final res = await DBProvider.db.getAllCausas();
    return res;
  }

  Future getAllCausasHttp()async{
    final causas = await _catalogoProvider.getCausas();
    for(var causa in causas){
      await ingresarCausa(causa);
    }
  }

}