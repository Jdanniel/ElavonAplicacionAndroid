

import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class CierresInstalacionBloc {
  final _noserieController = BehaviorSubject<String>();
  final _conectividadController = BehaviorSubject<String>();
  final _aplicativoController = BehaviorSubject<String>();
  final _versionController = BehaviorSubject<String>();
  final _bateriaController = BehaviorSubject<bool>();
  final _eliminadorController = BehaviorSubject<bool>();
  final _tapaController = BehaviorSubject<bool>();
  final _cableacController = BehaviorSubject<bool>();
  final _baseController = BehaviorSubject<bool>();
  final _isAmexController = BehaviorSubject<bool>();
  final _idamexController = BehaviorSubject<String>();
  final _afilamexController = BehaviorSubject<String>();
  final _conclusionesAmexController = BehaviorSubject<String>();
  final _notificadoController = BehaviorSubject<bool>();
  final _promocionesController = BehaviorSubject<bool>();
  final _descargarappController = BehaviorSubject<bool>();
  final _telefono1Controller = BehaviorSubject<String>();
  final _telefono2Controller = BehaviorSubject<String>();
  final _fechacierreController = BehaviorSubject<DateTime>();
  final _atiendeController = BehaviorSubject<String>();
  final _otorganteVoBoController = BehaviorSubject<String>();
  final _tipoatencionController = BehaviorSubject<String>();
  final _rollosController = BehaviorSubject<int>();
  final _discoverController = BehaviorSubject<int>();
  final _cajaController = BehaviorSubject<int>();
  final _comentariosController = BehaviorSubject<String>();

  Stream<String> get noserieStream => _noserieController.stream;
  Stream<String> get conectividadStream => _conectividadController.stream;
  Stream<String> get aplicativoStream => _aplicativoController.stream;
  Stream<String> get versionStream => _versionController.stream;
  Stream<bool> get bateriaStream => _bateriaController.stream;
  Stream<bool> get eliminadorStream => _eliminadorController.stream;
  Stream<bool> get tapaStream => _tapaController.stream;
  Stream<bool> get cableacStream => _cableacController.stream;
  Stream<bool> get baseStream => _baseController.stream;
  Stream<bool> get isamexStream => _isAmexController.stream;
  Stream<String> get idamexStream => _idamexController.stream;
  Stream<String> get afilamexStream => _afilamexController.stream;
  Stream<String> get conclusionesamexStream => _conclusionesAmexController.stream;
  Stream<bool> get notificadoStream => _notificadoController.stream;
  Stream<bool> get promocionesStream => _promocionesController.stream;
  Stream<bool> get descargarappStream => _descargarappController.stream;
  Stream<String> get telefono1Stream => _telefono1Controller.stream;
  Stream<String> get telefono2Stream => _telefono2Controller.stream;
  Stream<DateTime> get fechacierreStream => _fechacierreController.stream;
  Stream<String> get atiendeStream => _atiendeController.stream;
  Stream<String> get otorganteVoBoStream => _otorganteVoBoController.stream;
  Stream<String> get tipoatencionStream => _tipoatencionController.stream;
  Stream<int> get rollosStream => _rollosController.stream;
  Stream<int> get discoverStream => _discoverController.stream;
  Stream<int> get cajaStream => _cajaController.stream;
  Stream<String> get comentariosStream => _comentariosController.stream;

  Function(String) get changeNoserie => _noserieController.sink.add;
  Function(String) get changeConectividad => _conectividadController.sink.add;
  Function(String) get changeAplicativo => _aplicativoController.sink.add;
  Function(String) get changeVersion => _versionController.sink.add;
  Function(bool) get changeBateria => _bateriaController.sink.add;
  Function(bool) get changeEliminador => _eliminadorController.sink.add;
  Function(bool) get changeTapa => _tapaController.sink.add;
  Function(bool) get changeCableAc => _cableacController.sink.add;
  Function(bool) get changeBase => _baseController.sink.add;
  Function(bool) get changeIsAmex => _isAmexController.sink.add;
  Function(String) get changeIdAmex => _idamexController.sink.add;
  Function(String) get changeAfilAmex => _afilamexController.sink.add;
  Function(String) get changeConclusionesAmex => _conclusionesAmexController.sink.add;
  Function(bool) get changeNotificado => _notificadoController.sink.add;
  Function(bool) get changePromociones => _promocionesController.sink.add;
  Function(bool) get changeDescargarApp => _descargarappController.sink.add;
  Function(String) get changeTelefono1 => _telefono1Controller.sink.add;
  Function(String) get changeTelefono2 => _telefono2Controller.sink.add;
  Function(DateTime) get changeFechaCierre => _fechacierreController.sink.add;
  Function(String) get changeAtiende => _atiendeController.sink.add;
  Function(String) get changeOtorgante => _otorganteVoBoController.sink.add;
  Function(String) get changeTipoAtencion => _tipoatencionController.sink.add;
  Function(int) get changeRollos => _rollosController.sink.add;
  Function(int) get changeDiscover => _discoverController.sink.add;
  Function(int) get changeCaja => _cajaController.sink.add;
  Function(String) get changeComentarios => _comentariosController.sink.add;

  String get getNoSerie => _noserieController.value;
  String get getConectividad => _conectividadController.value;
  String get getAplicativo => _aplicativoController.value;
  String get getVersion => _versionController.value;
  bool get getBateria => _bateriaController.value;
  bool get getEliminador => _eliminadorController.value;
  bool get getTapa => _tapaController.value;
  bool get getCableAc => _cableacController.value;
  bool get getBase => _baseController.value;
  bool get getIsAmex => _isAmexController.value;
  String get getIdAmex => _idamexController.value;
  String get getAfilAmex => _afilamexController.value;
  String get getConclusionesAmex => _conclusionesAmexController.value;
  bool get getNotificado => _notificadoController.value;
  bool get getPromociones => _promocionesController.value;
  bool get getDescargarApp => _descargarappController.value;
  String get getTelefono1 => _telefono1Controller.value;
  String get getTelefono2 => _telefono2Controller.value;
  DateTime get getFechaCierre => _fechacierreController.value;
  String get getAtiende => _atiendeController.value;
  String get getOtorgante => _otorganteVoBoController.value;
  String get getTipoAtencion => _tipoatencionController.value;
  int get getRollos => _rollosController.value;
  int get getDiscover => _discoverController.value;
  int get getCaja => _cajaController.value;
  String get getComentarios => _comentariosController.value;

  Future<List<UnidadesModel>> getSeries(String serie) async {
    return DBProvider.db.getAllUnidadesBySerie(serie);
  }

  dispose(){
    _noserieController?.close();
    _conectividadController?.close();
    _aplicativoController?.close();
    _versionController?.close();
    _bateriaController?.close();
    _eliminadorController?.close();
    _tapaController?.close();
    _cableacController?.close();
    _baseController?.close();
    _isAmexController?.close();
    _idamexController?.close();
    _afilamexController?.close();
    _conclusionesAmexController?.close();
    _notificadoController?.close();
    _promocionesController?.close();
    _descargarappController?.close();
    _telefono1Controller?.close();
    _telefono2Controller?.close();
    _fechacierreController?.close();
    _atiendeController?.close();
    _otorganteVoBoController?.close();
    _tipoatencionController?.close();
    _rollosController?.close();
    _discoverController?.close();
    _cajaController?.close();
    _comentariosController?.close();
  }

}