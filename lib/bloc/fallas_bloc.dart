import 'package:elavonappmovil/models/fallas_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class FallasBloc{

  final catalogosProvider = CatalogoProvider();

  Future getFallasHttp() async{
    final fallas = await catalogosProvider.getFallas();
    for(final falla in fallas){
      await insertFalla(falla);
    }
  }

  Future insertFalla(FallasModel model)async{
    await DBProvider.db.nuevoFalla(model);
  }

}