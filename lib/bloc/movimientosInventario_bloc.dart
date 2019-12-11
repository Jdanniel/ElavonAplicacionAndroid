
import 'package:elavonappmovil/models/movimientoInventarioServicioFalla_model.dart';
import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';

class MovimientosInventarioBloc{

  final _catalogoProvider = new CatalogoProvider();

  Future getAllMovimientosInventarioHttp() async {
    final movimientos = await _catalogoProvider.getMovInventarioSF();
    for(var movimiento in movimientos){
      await insertarMovimientosInventario(movimiento);
    }
  }

  Future insertarMovimientosInventario(MovimientoInventarioSF model) async {
    await DBProvider.db.nuevoMovInv(model);
  }
}