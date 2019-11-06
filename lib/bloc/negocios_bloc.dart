
import 'package:elavonappmovil/models/negocios_model.dart';
import 'package:elavonappmovil/provider/negocios_provider.dart';

class NegociosBloc{

  final _provider = NegociosProvider();


  Future<int> updateCoordenadas(NegociosModel model) async {
    int r = await _provider.updateCoordenadas(model);
    return r;
  }


}