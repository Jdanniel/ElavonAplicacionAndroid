import 'dart:io';

import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
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
      "INSERT INTO $tableservicios(idservicio,descservicio)" +
      "VALUES (${nuevoServicio.idServicio},'${nuevoServicio.descServicio}')"
    );
    return res;
  }

  nuevoModelo(CmodelosModel nuevoModelo) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableModelos(idmodelo,descmodelo)" +
      "VALUES (${nuevoModelo.idModelo},'${nuevoModelo.descModelo}')"
    );
    return res;
  }

  nuevoMarcas(MarcasModel nuevoMarcas) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableMarcas(idmarca,descmarca)" +
      "VALUES (${nuevoMarcas.idMarca},'${nuevoMarcas.descMarca}')"
    );
    return res;
  }

   nuevoConectividad(ConectividadModel nuevoConectividad) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableConectividad(idconectividad,descconectividad)" +
      "VALUES (${nuevoConectividad.idConectividad},'${nuevoConectividad.descConectividad}')"
    );
    return res;
  }

   nuevoSoftware(Softwaremodel nuevoSoftware) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableSoftware(idsoftware,descmarca)" +
      "VALUES (${nuevoSoftware.idSoftware},'${nuevoSoftware.descSoftware}')"
    );
    return res;
  }

   nuevoUnidad(UnidadesModel nuevoUnidad) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO $tableUnidades(idunidad,noserie,idmarca,idmodelo,idconectividad,idaplicativo)" +
      "VALUES (${nuevoUnidad.idUnidad},'${nuevoUnidad.noSerie}',${nuevoUnidad.idMarca},${nuevoUnidad.idModelo},${nuevoUnidad.idConectividad},${nuevoUnidad.idAplicativo})"
    );
    return res;
  }

  //Seleccionar

  Future<ServiciosModel> getServicioId(int id) async{
    final db = await database;
    final res = await db.query(tableservicios, where: 'idservicio = ?', whereArgs: [id]);

    return res.isNotEmpty ? ServiciosModel.fromJson(res.first) : null;
  }

  Future<CmodelosModel> getModeloId(int id) async{
    final db = await database;
    final res = await db.query(tableModelos, where: 'idmodelo = ?', whereArgs: [id]);

    return res.isNotEmpty ? CmodelosModel.fromJson(res.first) : null;
  }
}