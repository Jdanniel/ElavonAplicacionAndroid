import 'dart:io';

import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/models/updates_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {


  static Database _database;
  static final DBProvider db = DBProvider._();

  //NOMBRE DE TABLAS
  final String tableservicios = 'Cservicios';
  final String tableModelos = 'Cmodelos';
  final String tableMarcas = 'Cmarcas';
  final String tableConectividad = 'Cconectividad';
  final String tableSoftware = 'Csoftware';
  final String tableUnidades = 'Bdunidades';
  final String tableUpdates = 'Cupdates';

  DBProvider._();

  Future<Database> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{

    //DEFINIR PATH
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ElavonDB.db');

    //BORRAR BASE DE DATOS
    // final bool isexistsDb = await databaseExists(path);
    // if(isexistsDb) await deleteDatabase(path);
    await deleteDatabase(path);
    final String queryServicios = 'CREATE TABLE $tableservicios ( idservicio INTEGER NOT NULL, descservicio TEXT)';
    final String queryModelos = 'CREATE TABLE $tableModelos ( idmodelo INTEGER NOT NULL, descmodelo TEXT)';
    final String queryMarcas = 'CREATE TABLE $tableMarcas ( idmarca INTEGER NOT NULL, descmarca TEXT)';
    final String queryConectividad = 'CREATE TABLE $tableConectividad ( idconectividad INTEGER NOT NULL, descconectividad TEXT)';
    final String querySoftware = 'CREATE TABLE $tableSoftware ( idsoftware INTEGER NOT NULL, descsoftware TEXT)';
    final String queryUnidades = 'CREATE TABLE $tableUnidades (idunidad INTEGER NOT NULL, noserie TEXT, idmarca INTEGER, idmodelo INTEGER, idconectividad INTEGER, idaplicativo INTEGER)';
    final String queryUpdates = 'CREATE TABLE $tableUpdates ( idupdates INTEGER PRIMARY KEY, fecupdates TEXT)';

    return await openDatabase(path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(queryServicios);
        await db.execute(queryModelos);
        await db.execute(queryMarcas);
        await db.execute(queryConectividad);
        await db.execute(querySoftware);
        await db.execute(queryUnidades);
        await db.execute(queryUpdates);
        // await db.close();
      }
    );
  }

  //INSERTAR

  nuevoServicio(ServiciosModel nuevoServicio) async{
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableservicios(idservicio,descservicio)" +
      "VALUES (${nuevoServicio.idServicio},'${nuevoServicio.descServicio}')"
    );
    // await db.close();
    return res;
  }

  nuevoModelo(CmodelosModel nuevoModelo) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableModelos(idmodelo,descmodelo)" +
      "VALUES (${nuevoModelo.idModelo},'${nuevoModelo.descModelo}')"
    );
    // await db.close();
    return res;
  }

  nuevoMarcas(MarcasModel nuevoMarcas) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableMarcas(idmarca,descmarca)" +
      "VALUES (${nuevoMarcas.idMarca},'${nuevoMarcas.descMarca}')"
    );
    // await db.close();
    return res;
  }

   nuevoConectividad(ConectividadModel nuevoConectividad) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableConectividad(idconectividad,descconectividad)" +
      "VALUES (${nuevoConectividad.idConectividad},'${nuevoConectividad.descConectividad}')"
    );
    // await db.close();
    return res;
  }

   nuevoSoftware(Softwaremodel nuevoSoftware) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableSoftware(idsoftware,descsoftware)" +
      "VALUES (${nuevoSoftware.idSoftware},'${nuevoSoftware.descSoftware}')"
    );
    // await db.close();
    return res;
  }

   nuevoUnidad(UnidadesModel nuevoUnidad) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableUnidades(idunidad,noserie,idmarca,idmodelo,idconectividad,idaplicativo)" +
      "VALUES (${nuevoUnidad.idUnidad},'${nuevoUnidad.noSerie}',${nuevoUnidad.idMarca},${nuevoUnidad.idModelo},${nuevoUnidad.idConectividad},${nuevoUnidad.idAplicativo})"
    );
    // await db.close();
    return res;
  }

   nuevoUpdate(UpdatesModel model) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableUpdates(fecupdates)" +
      "VALUES ('${model.fecha}}')"
    );
    // await db.close();
    return res;
  }

  //Seleccionar por id

  Future<ServiciosModel> getServicioId(int id) async{
    final db = await database;
    final res = await db.query(tableservicios, where: 'idservicio = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? ServiciosModel.fromJson(res.first) : null;
  }

  Future<CmodelosModel> getModeloId(int id) async{
    final db = await database;
    final res = await db.query(tableModelos, where: 'idmodelo = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? CmodelosModel.fromJson(res.first) : null;
  }

  Future<MarcasModel> getMarcasId(int id) async{
    final db = await database;

    final res = await db.query(tableMarcas, where: 'idmarca = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? MarcasModel.fromJson(res.first) : null;
  }

  Future<ConectividadModel> getConectividadId(int id) async{
    final db = await database;

    final res = await db.query(tableConectividad, where: 'idconectividad = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? ConectividadModel.fromJson(res.first) : null;
  }

  Future<Softwaremodel> getSoftwareId(int id) async{
    final db = await database;

    final res = await db.query(tableSoftware, where: 'idsoftware = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? Softwaremodel.fromJson(res.first) : null;
  }

  Future<UnidadesModel> getUnidadId(int id) async{
    final db = await database;

    final res = await db.query(tableUnidades, where: 'idunidad = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? UnidadesModel.fromJson(res.first) : null;
  }    

  Future<UpdatesModel> getLastUpdate() async{
    final db = await database;
    final res = await db.query('$tableUpdates',orderBy: 'idupdates DESC', limit: 1);
    return res.isNotEmpty ? UpdatesModel.fromJson(res.first) : null;
  }

  //Seleccionar Todos
  Future<List<ServiciosModel>> getAllServicio() async{
    final db = await database;
    final res = await db.query(tableservicios);

    List<ServiciosModel> list = res.isNotEmpty 
                              ? res.map((s) => ServiciosModel.fromJson(s)).toList()
                              : [];
    // await db.close();                              
    return list;
  }

  Future<List<CmodelosModel>> getAllModelos() async{
    final db = await database;
    final res = await db.query(tableModelos);

    List<CmodelosModel> list = res.isNotEmpty 
                              ? res.map((s) => CmodelosModel.fromJson(s)).toList()
                              : [];
    // await db.close();                       
    return list;
  }  

  Future<List<MarcasModel>> getAllMarcas() async{
    final db = await database;
    final res = await db.query(tableMarcas);

    List<MarcasModel> list = res.isNotEmpty 
                              ? res.map((s) => MarcasModel.fromJson(s)).toList()
                              : [];
    // await db.close();              
    return list;
  }  

  Future<List<ConectividadModel>> getAllConectividad() async{
    final db = await database;
    final res = await db.query(tableConectividad);

    List<ConectividadModel> list = res.isNotEmpty 
                              ? res.map((s) => ConectividadModel.fromJson(s)).toList()
                              : [];
    // await db.close();               
    return list;
  } 

  Future<List<Softwaremodel>> getAllSoftware() async{
    final db = await database;
    final res = await db.query(tableSoftware);

    List<Softwaremodel> list = res.isNotEmpty 
                              ? res.map((s) => Softwaremodel.fromJson(s)).toList()
                              : [];
    // await db.close();     
    return list;
  }      

  Future<List<UnidadesModel>> getAllUnidades() async{
    final db = await database;
    final res = await db.query(tableUnidades);

    List<UnidadesModel> list = res.isNotEmpty 
                              ? res.map((s) => UnidadesModel.fromJson(s)).toList()
                              : [];
    // await db.close();                   
    return list;
  }    

  //Actualizar
  Future<int> updateServicio(ServiciosModel nuevoServicio) async{
    final db = await database;
    final res = await db.update(tableservicios, nuevoServicio.toJson(), where: 'id = ?', whereArgs: [nuevoServicio.idServicio]);
    // await db.close();
    return res;
  }

  //Eliminar uno
  Future<int> deleteServicio(int id) async {
    final db = await database;
    final res = await db.delete(tableservicios, where: 'id = ?', whereArgs: [id]);
    // await db.close();
    return res;
  }

  //Eliminar todo
}