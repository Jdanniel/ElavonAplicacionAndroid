
import 'package:rxdart/rxdart.dart';

class CierresRetiroBloc{

  final _noserieController = BehaviorSubject<String>();
  final _marcaController = BehaviorSubject<String>();
  final _modeloController = BehaviorSubject<String>();
  final _conectividadController = BehaviorSubject<String>();
  final _aplicativoController = BehaviorSubject<String>();
  final _versionController = BehaviorSubject<String>();

  final _bateriaController = BehaviorSubject<bool>();
  final _eliminadorController = BehaviorSubject<bool>();
  final _tapaController = BehaviorSubject<bool>();
  final _cableacController = BehaviorSubject<bool>();
  final _baseController = BehaviorSubject<bool>();

  final _fechacierreController = BehaviorSubject<DateTime>();
  final _atiendeController = BehaviorSubject<String>();
  final _otorganteVoBoController = BehaviorSubject<String>();
  final _tipoatencionController = BehaviorSubject<String>();
  final _rollosController = BehaviorSubject<int>();
  final _discoverController = BehaviorSubject<int>();
  final _cajaController = BehaviorSubject<int>();

  final _comentariosController = BehaviorSubject<String>();

  Stream<String> get noserieStream => _noserieController.stream;
  Stream<String> get marcaStream => _marcaController.stream;
  Stream<String> get modeloStream => _modeloController.stream;
  Stream<String> get conectividadStream => _conectividadController.stream;
  Stream<String> get aplicativoStream => _aplicativoController.stream;
  Stream<String> get versionStream => _versionController.stream;

  Stream<bool> get bateriaStream => _bateriaController.stream;
  Stream<bool> get eliminadorStream => _eliminadorController.stream;
  Stream<bool> get tapaStream => _tapaController.stream;
  Stream<bool> get cableacStream => _cableacController.stream;
  Stream<bool> get baseStream => _baseController.stream;

  Stream<DateTime> get fechacierreStream => _fechacierreController.stream;
  Stream<String> get atiendeStream => _atiendeController.stream;
  Stream<String> get otorganteVoBoStream => _otorganteVoBoController.stream;
  Stream<String> get tipoatencionStream => _tipoatencionController.stream;
  Stream<int> get rollosStream => _rollosController.stream;
  Stream<int> get discoverStream => _discoverController.stream;
  Stream<int> get cajaStream => _cajaController.stream;

  Stream<String> get comentariosStream => _comentariosController.stream;  

  Function(String) get changeNoserie => _noserieController.sink.add;
  Function(String) get changeMarca => _marcaController.sink.add;
  Function(String) get changeModelo => _modeloController.sink.add;
  Function(String) get changeConectividad => _conectividadController.sink.add;
  Function(String) get changeAplicativo => _aplicativoController.sink.add;
  Function(String) get changeVersion => _versionController.sink.add;

  Function(bool) get changeBateria => _bateriaController.sink.add;
  Function(bool) get changeEliminador => _eliminadorController.sink.add;
  Function(bool) get changeTapa => _tapaController.sink.add;
  Function(bool) get changeCableAc => _cableacController.sink.add;
  Function(bool) get changeBase => _baseController.sink.add;

  Function(DateTime) get changeFechaCierre => _fechacierreController.sink.add;
  Function(String) get changeAtiende => _atiendeController.sink.add;
  Function(String) get changeOtorgante => _otorganteVoBoController.sink.add;
  Function(String) get changeTipoAtencion => _tipoatencionController.sink.add;
  Function(int) get changeRollos => _rollosController.sink.add;
  Function(int) get changeDiscover => _discoverController.sink.add;
  Function(int) get changeCaja => _cajaController.sink.add;

  Function(String) get changeComentarios => _comentariosController.sink.add;

  String get getNoSerie => _noserieController.value;
  String get getMarca => _marcaController.value;
  String get getModelo => _modeloController.value;
  String get getConectividad => _conectividadController.value;
  String get getAplicativo => _aplicativoController.value;
  String get getVersion => _versionController.value;
  bool get getBateria => _bateriaController.value;
  bool get getEliminador => _eliminadorController.value;
  bool get getTapa => _tapaController.value;
  bool get getCableAc => _cableacController.value;
  bool get getBase => _baseController.value;
  DateTime get getFechaCierre => _fechacierreController.value;
  String get getAtiende => _atiendeController.value;
  String get getOtorgante => _otorganteVoBoController.value;
  String get getTipoAtencion => _tipoatencionController.value;
  int get getRollos => _rollosController.value;
  int get getDiscover => _discoverController.value;
  int get getCaja => _cajaController.value;
  String get getComentarios => _comentariosController.value;

  dispose(){
    _noserieController?.close();
    _marcaController?.close();
    _modeloController?.close();
    _conectividadController?.close();
    _aplicativoController?.close();
    _versionController?.close();
    _bateriaController?.close();
    _eliminadorController?.close();
    _tapaController?.close();
    _cableacController?.close();
    _baseController?.close();
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