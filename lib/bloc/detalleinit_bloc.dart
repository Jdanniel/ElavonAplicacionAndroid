import 'package:elavonappmovil/models/movimientoInventarioServicioFalla_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class DetalleInitBloc{


  Future<MovimientoInventarioSF> getMovInventariosf(int idservicio, int idfalla)async{
    MovimientoInventarioSF mov = await DBProvider.db.getMovInventarioSF(idservicio,idfalla);
    return mov;
  }

}