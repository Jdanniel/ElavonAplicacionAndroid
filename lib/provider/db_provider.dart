import 'dart:io';

import 'package:elavonappmovil/models/servicios_model.dart';
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

    final String queryServicios = 'CREATE TABLE $tableservicios ( idservicio INTEGER PRIMARY KEY, descservicio TEXT)';
    final String queryModelos = 'CREATE TABLE $tableModelos ( idmodelo INTEGER PRIMARY KEY, descmodelo TEXT)';
    final String queryMarcas = 'CREATE TABLE $tableMarcas ( idmarca INTEGER PRIMARY KEY, descmarca TEXT)';
    final String queryConectividad = 'CREATE TABLE $tableConectividad ( idconectividad INTEGER PRIMARY KEY, descconectividad TEXT)';
    final String querySoftware = 'CREATE TABLE $tableSoftware ( idsoftware INTEGER PRIMARY KEY, descsoftware TEXT)';
    final String queryUnidades = 'CREATE TABLE $tableUnidades (idunidad INTEGER PRIMARY KEY, noserie TEXT, idmarca INTEGER, idmodelo INTEGER, idconectividad INTEGER, idaplicativo INTEGER)';


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
      }
    );
  }


  //INSERTAR

  nuevoServicio(ServiciosModel nuevoServicio) async{
    final db = await database;

    final res = await db.rawInsert(
      'INSERT INTO $tableservicios()'
    );
  }


}