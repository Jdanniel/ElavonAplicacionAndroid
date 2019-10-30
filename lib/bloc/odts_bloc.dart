import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/provider/odt_provider.dart';

class OdtsBloc{

  //Stream
  final _allodtsController = new BehaviorSubject<List<Odtmodel>>();
  final _allodtsbyDateController = new BehaviorSubject<List<Odtmodel>>();
  final _odtController = new BehaviorSubject<Odtmodel>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _updateStatusController = new BehaviorSubject<int>();

  final _odtsProvider = new OdtProvider();

  //Escuchar Steams
  Stream<List<Odtmodel>> get allodtsbyDateStream => _allodtsbyDateController.stream;
  Stream<List<Odtmodel>> get allodtsStream => _allodtsController.stream;
  Stream<Odtmodel> get odtStrem => _odtController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  //Insertar Metodos de Odts

  Future insertarOdts(Odtmodel model) async{
    await DBProvider.db.nuevoArs(model);
  }

  void selectOdt(int id) async{
    final odt = await DBProvider.db.getOdtsId(id);
    _odtController.sink.add(odt);
  }

  void selectAllOdts() async{
    final odts = await DBProvider.db.getAllArs();
    _allodtsController.sink.add(odts);
  }

  void selectAllOdtsbyDate(int day, int month, int year) async{
    final odts = await DBProvider.db.getAllArsbyDate(day, month, year);
    _allodtsbyDateController.sink.add(odts);
  }

  void updateStatusAr(int idusuario, int idstatusara, int idstatusarp, int idar) async{
    final status = await _odtsProvider.updateStatusAr(idusuario,idstatusara,idstatusarp,idar);
    print(status);
  }

  Future<List<Odtmodel>> selectAllOdtsbyDate2 (int day, int month, int year) async{
    final odts = await DBProvider.db.getAllArsbyDate(day, month, year);
    return odts;
  }

  Future<List<Odtmodel>> getAllOdtsHttp() async{
    final odts = await _odtsProvider.getOdts();
    return odts;
  }

  Future<List<Odtmodel>> getAllOdtsOrderbyDate() async{
    final odts = await DBProvider.db.getAllArsGroupByDate();
    return odts;
  }

  dispose(){
    _allodtsbyDateController?.close();
    _allodtsController?.close();
    _odtController?.close();
    _cargandoController?.close();
    _updateStatusController?.close();
  }

}