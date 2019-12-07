
import 'package:elavonappmovil/models/ccausas_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class CausasBloc{

  Future<int> ingresarCausa(CCausasModel model) async {
    final res = await DBProvider.db.nuevaCausa(model);
    return res;
  }

  Future<CCausasModel> getCausa(int idcausa) async{
    final ress = await DBProvider.db.getCausas(idcausa);
    return ress;
  }

  Future<List<CCausasModel>> getAllCausas()async{
    final res = await DBProvider.db.getAllCausas();
    return res;
  }

}