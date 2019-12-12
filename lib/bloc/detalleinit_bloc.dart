import 'package:elavonappmovil/models/cambiostatusarrequest_model.dart';
import 'package:elavonappmovil/models/movimientoInventarioServicioFalla_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class DetalleInitBloc{

  final _pageReturnController = BehaviorSubject<int>();

  Stream<int> get pageReturnStream => _pageReturnController.stream;

  Function(int) get changePageReturn => _pageReturnController.sink.add;

  int get getPageReturn => _pageReturnController.value;

  Future<MovimientoInventarioSF> getMovInventariosf(int idservicio, int idfalla)async{
    MovimientoInventarioSF mov = await DBProvider.db.getMovInventarioSF(idservicio,idfalla);
    return mov;
  }

  Future<StatusCambioResponseModel> getCambioStatusValido(int id) async {
    final res = await DBProvider.db.getCambioStatusResponse(id);
    return res;
  }

  Future<int> getStatusCambio(int id) async {

  }

  dispose(){
    _pageReturnController?.close();
  }
}