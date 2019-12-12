import 'dart:io';

import 'package:elavonappmovil/data/database_ars.dart';
import 'package:elavonappmovil/data/database_cambiostatusar.dart';
import 'package:elavonappmovil/data/database_causas.dart';
import 'package:elavonappmovil/data/database_conectividades.dart';
import 'package:elavonappmovil/data/database_fallas.dart';
import 'package:elavonappmovil/data/database_marcas.dart';
import 'package:elavonappmovil/data/database_modelos.dart';
import 'package:elavonappmovil/data/database_movimientoinventarioServicioFalla.dart';
import 'package:elavonappmovil/data/database_servicios.dart';
import 'package:elavonappmovil/data/database_software.dart';
import 'package:elavonappmovil/data/database_statusar.dart';
import 'package:elavonappmovil/data/database_unidades.dart';
import 'package:elavonappmovil/models/bdcambiostatusar_model.dart';
import 'package:elavonappmovil/models/cambiostatusarrequest_model.dart';
import 'package:elavonappmovil/models/ccausas_model.dart';
import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/cstatusar_model.dart';
import 'package:elavonappmovil/models/fallas_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/movimientoInventarioServicioFalla_model.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/totalodts_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/models/updates_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  final String tableUpdates = 'Cupdates';

  DBProvider._();

  Future<Database> get database async {
    final path = await getPath();

    if (_database != null) {
      return _database;
    }

    _database = await initDB(path);
    return _database;
  }

  Future<String> getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ElavonDB.db');
    return path;
  }

  deletedb() async {
    final path = await getPath();
    await deleteDatabase(path);
  }

  initDB(String path) async {
    //await deleteDatabase(path);
    final String queryServicios =
        'CREATE TABLE ${Cservicios.table} ( ${Cservicios.columnID} INTEGER NOT NULL, ${Cservicios.columnDESCSERVICIO} TEXT)';
    final String queryFallas =
        'CREATE TABLE ${Cfallas.table} (${Cfallas.columnIDFALLA} INTEGER NOT NULL, ${Cfallas.columnDESCFALLA} TEXT)';
    final String queryModelos =
        'CREATE TABLE ${CModelos.table} ( ${CModelos.columnID} INTEGER NOT NULL, ${CModelos.columnDESCMODELO} TEXT)';
    final String queryMarcas =
        'CREATE TABLE ${CMarcas.table} ( ${CMarcas.columnID} INTEGER NOT NULL, ${CMarcas.columnDESCMARCA} TEXT)';
    final String queryConectividad =
        'CREATE TABLE ${CConectividades.table} ( ${CConectividades.columnID} INTEGER NOT NULL, ${CConectividades.columnDESCCONECTIVIDAD} TEXT)';
    final String querySoftware =
        'CREATE TABLE ${CSoftware.table} ( ${CSoftware.columnID} INTEGER NOT NULL, ${CSoftware.columnDESCSOFTWARE} TEXT)';
    final String queryUnidades =
        'CREATE TABLE ${Bdunidades.table} (${Bdunidades.columnID} INTEGER NOT NULL, ${Bdunidades.columnNOSERIE} TEXT, ${Bdunidades.columnIDMARCA} INTEGER, ${Bdunidades.columnIDMODELO} INTEGER, ${Bdunidades.columnIDCONECTIVIDAD} INTEGER, ${Bdunidades.columnIDAPLICATIVO} INTEGER)';
    final String queryUpdates =
        'CREATE TABLE $tableUpdates ( idupdates INTEGER PRIMARY KEY, fecha TEXT)';
    final String queryArs =
        'CREATE TABLE ${BdArs.table} (${BdArs.columnID} INTEGER NOT NULL, ${BdArs.columnNOAR} TEXT, ${BdArs.columnIDNEGOCIO} INTEGER, ${BdArs.columnIDTIPOSERVICIO} INTEGER, ${BdArs.columnDESCNEGOCIO} TEXT, ${BdArs.columnNOAFILIACION} TEXT, ${BdArs.columnESTADO} TEXT, ${BdArs.columnCOLONIA} TEXT, ${BdArs.columnPOBLACION} TEXT, ${BdArs.columnDIRECCION} TEXT, ${BdArs.columnFECGARANTIA} TEXT, ${BdArs.columnLATITUD} REAL, ${BdArs.columnLONGITUD} REAL, ${BdArs.columnDAYS} INTEGER, ${BdArs.columnMONTHS} INTEGER, ${BdArs.columnYEARS} INTEGER, ${BdArs.columnNUMBERS} INTEGER, ${BdArs.columnIDSTATUSAR} INTEGER, ${BdArs.columnIDSERVICIO} INTEGER, ${BdArs.columnIDFALLA} INTEGER, ${BdArs.columnSTATUSAR} TEXT)';
    final String queryMovInventarioSF =
        'CREATE TABLE ${CmovimientoInventarioServicioFalla.table} (${CmovimientoInventarioServicioFalla.columnID} INTEGER NOT NULL, ${CmovimientoInventarioServicioFalla.columnIDSERVICIO} INT, ${CmovimientoInventarioServicioFalla.columnIDFALLA} INT, ${CmovimientoInventarioServicioFalla.columnIDMOVINVENTARIO} INT, ${CmovimientoInventarioServicioFalla.columnSTATUS} TEXT)';
    final String queryCcausas =
        'CREATE TABLE ${Causas.table} (${Causas.columnId} INTEGER NOT NULL, ${Causas.columnDESCCAUSA} TEXT,${Causas.columnDESCRIPCION} TEXT)';
    final String queryCstatusAr = 
        'CREATE TABLE ${CstausAr.table} (${CstausAr.columnID} INTEGER NOT NULL, ${CstausAr.columnDESCSTATUSAR} TEXT)';
    final String querybdCambioStatusAr = 
        'CREATE TABLE ${BdCambioStatusAr.table} (${BdCambioStatusAr.columnID} INTEGER NOT NULL, ${BdCambioStatusAr.columnIDSTATUSARINI} INTEGER, ${BdCambioStatusAr.columnIDSTATUSARFIN} INTEGER)';

    return await openDatabase(path,
        version: 1,
        readOnly: false,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(queryServicios);
      await db.execute(queryFallas);
      await db.execute(queryModelos);
      await db.execute(queryMarcas);
      await db.execute(queryConectividad);
      await db.execute(querySoftware);
      await db.execute(queryUnidades);
      await db.execute(queryUpdates);
      await db.execute(queryArs);
      await db.execute(queryMovInventarioSF);
      await db.execute(queryCcausas);
      await db.execute(queryCstatusAr);
      await db.execute(querybdCambioStatusAr);
      // await db.close();
    });
  }

  //INSERTAR

  nuevoServicio(ServiciosModel nuevoServicio) async {
    final db = await database;

    final res = await db.transaction((txn) async {
      var query =
          "INSERT INTO ${Cservicios.table}(${Cservicios.columnID}, ${Cservicios.columnDESCSERVICIO}) VALUES (${nuevoServicio.idServicio},'${nuevoServicio.descServicio}')";
      return await txn.rawInsert(query);
    });
    return res;
  }

  nuevoFalla(FallasModel nuevoFalla) async {
    final db = await database;

    final res = await db.transaction((txn) async {
      var query =
          "INSERT INTO ${Cfallas.table}(${Cfallas.columnIDFALLA},${Cfallas.columnDESCFALLA}) VALUES (${nuevoFalla.idFalla}, '${nuevoFalla.descFalla}')";
      return await txn.rawInsert(query);
    });
    return res;
  }

  nuevoStatusAr(CStatusArModel nuevoStatus) async {
    final db = await database;
    final res = await db.transaction((txn) async {
      var query = 
          "INSERT INTO ${CstausAr.table} (${CstausAr.columnID}, ${CstausAr.columnDESCSTATUSAR}) VALUES(${nuevoStatus.idStatusAr}, '${nuevoStatus.descStatusAr}')";
      return await txn.rawInsert(query);
    });
    return res;
  }

  nuevoCambioStatusAr(BdCambioStatusArModel nuevoCambio) async {
    final db = await database;
    final res = await db.transaction((txn) async {
      var query = 
                "INSERT INTO ${BdCambioStatusAr.table} (${BdCambioStatusAr.columnID}, ${BdCambioStatusAr.columnIDSTATUSARINI}, ${BdCambioStatusAr.columnIDSTATUSARFIN}) VALUES(${nuevoCambio.idCambioStatusAr},${nuevoCambio.idStatusArIni}, ${nuevoCambio.idStatusArFin})";
      return await txn.rawInsert(query);  
    });
    return res;
  }

  nuevoModelo(CmodelosModel nuevoModelo) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO ${CModelos.table}(${CModelos.columnID},${CModelos.columnDESCMODELO})" +
            "VALUES (${nuevoModelo.idModelo},'${nuevoModelo.descModelo}')");
    // await db.close();
    return res;
  }

  nuevoMarcas(MarcasModel nuevoMarcas) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO ${CMarcas.table}(${CMarcas.columnID},${CMarcas.columnDESCMARCA})" +
            "VALUES (${nuevoMarcas.idMarca},'${nuevoMarcas.descMarca}')");
    // await db.close();
    return res;
  }

  nuevoConectividad(ConectividadModel nuevoConectividad) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO ${CConectividades.table}(${CConectividades.columnID},${CConectividades.columnDESCCONECTIVIDAD})" +
            "VALUES (${nuevoConectividad.idConectividad},'${nuevoConectividad.descConectividad}')");
    // await db.close();
    return res;
  }

  nuevoSoftware(Softwaremodel nuevoSoftware) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO ${CSoftware.table}(${CSoftware.columnID},${CSoftware.columnDESCSOFTWARE})" +
            "VALUES (${nuevoSoftware.idSoftware},'${nuevoSoftware.descSoftware}')");
    // await db.close();
    return res;
  }

  nuevoUnidad(UnidadesModel nuevoUnidad) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO ${Bdunidades.table}(${Bdunidades.columnID},${Bdunidades.columnNOSERIE},${Bdunidades.columnIDMARCA},${Bdunidades.columnIDMODELO},${Bdunidades.columnIDCONECTIVIDAD},${Bdunidades.columnIDAPLICATIVO})" +
            "VALUES (${nuevoUnidad.idUnidad},'${nuevoUnidad.noSerie}',${nuevoUnidad.idMarca},${nuevoUnidad.idModelo},${nuevoUnidad.idConectividad},${nuevoUnidad.idAplicativo})");
    // await db.close();
    return res;
  }

  nuevoUpdate(UpdatesModel model) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO $tableUpdates(fecha)" + "VALUES ('${model.fecha}}')");
    // await db.close();
    return res;
  }

  nuevoArs(Odtmodel model) async {
    final db = await database;

    final res = await db.rawInsert("INSERT INTO ${BdArs.table}( "
        "${BdArs.columnID},"
        "${BdArs.columnNOAR},"
        "${BdArs.columnIDNEGOCIO},"
        "${BdArs.columnIDTIPOSERVICIO},"
        "${BdArs.columnDESCNEGOCIO},"
        "${BdArs.columnNOAFILIACION},"
        "${BdArs.columnESTADO},"
        "${BdArs.columnCOLONIA},"
        "${BdArs.columnPOBLACION},"
        "${BdArs.columnDIRECCION},"
        "${BdArs.columnFECGARANTIA},"
        "${BdArs.columnLATITUD},"
        "${BdArs.columnLONGITUD},"
        "${BdArs.columnDAYS},"
        "${BdArs.columnMONTHS},"
        "${BdArs.columnYEARS},"
        "${BdArs.columnNUMBERS},"
        "${BdArs.columnIDSTATUSAR},"
        "${BdArs.columnIDSERVICIO},"
        "${BdArs.columnIDFALLA},"
        "${BdArs.columnSTATUSAR}"
        ") VALUES("
        "${model.idAr},"
        "'${model.odt}',"
        "${model.idNegocio},"
        "${model.idTipoServicio},"
        "'${model.negocio}',"
        "'${model.noAfiliacion}',"
        "'${model.estado}',"
        "'${model.colonia}',"
        "'${model.poblacion}',"
        "'${model.direccion}',"
        "'${model.fecGarantia}',"
        "${model.latitud},"
        "${model.longitud},"
        "${model.days},"
        "${model.months},"
        "${model.years},"
        "${model.numbers},"
        "${model.idStatusAr},"
        "${model.idServicio},"
        "${model.idFalla},"
        "'${model.estatusAr}'"
        ")");
    return res;
  }

  nuevoMovInv(MovimientoInventarioSF model) async {
    final db = await database;
    final res = await db
        .rawInsert("INSERT INTO ${CmovimientoInventarioServicioFalla.table} "
            "( "
            "${CmovimientoInventarioServicioFalla.columnID}, "
            "${CmovimientoInventarioServicioFalla.columnIDSERVICIO}, "
            "${CmovimientoInventarioServicioFalla.columnIDFALLA}, "
            "${CmovimientoInventarioServicioFalla.columnIDMOVINVENTARIO}, "
            "${CmovimientoInventarioServicioFalla.columnSTATUS}"
            ") VALUES ("
            "${model.idValMovimientosInvServicioFalla}, "
            "${model.idServicio}, "
            "${model.idFalla}, "
            "${model.idMovInventario}, "
            "'${model.status}' )");
    return res;
  }

  nuevaCausa(CCausasModel model) async {
    final db = await database;
    final res = await db.rawInsert("INSERT INTO ${Causas.table} ("
        "${Causas.columnId},"
        "${Causas.columnDESCCAUSA},"
        "${Causas.columnDESCRIPCION}"
        ") VALUES ("
        "${model.idCausa},"
        "'${model.descCausa}',"
        "'${model.descripcion}'"
        ")");
    return res;
  }

  //Seleccionar por id

  Future<ServiciosModel> getServicioId(int id) async {
    final db = await database;
    final res = await db.query(Cservicios.table,
        where: '${Cservicios.columnID} = ?', whereArgs: [id]);
    return res.isNotEmpty ? ServiciosModel.fromJson(res.first) : null;
  }

  Future<FallasModel> getFallaId(int id) async {
    final db = await database;

    final res = await db.transaction((txn) async {
      return await txn.query(Cfallas.table,
          where: '${Cfallas.columnIDFALLA} = ?', whereArgs: [id]);
    });

    return res.isNotEmpty ? FallasModel.fromJson(res.first) : null;
  }

  Future<CStatusArModel> getStatusArId(int id) async {
    final db = await database;

    final res = await db.transaction((txn) async {
      return await txn.query(CstausAr.table,
          where: '${CstausAr.columnID} = ?', whereArgs: [id]);
    });

    return res.isNotEmpty ? CStatusArModel.fromJson(res.first) : null;
  }

  Future<BdCambioStatusArModel> getCambioStatusArId(int id) async {
    final db = await database;

    final res = await db.transaction((txn) async {
      return await txn.query(BdCambioStatusAr.table,
          where: '${BdCambioStatusAr.columnID} = ?', whereArgs: [id]);
    });

    return res.isNotEmpty ? BdCambioStatusArModel.fromJson(res.first) : null;
  } 

  Future<CmodelosModel> getModeloId(int id) async {
    final db = await database;
    final res = await db.query(CModelos.table,
        where: '${CModelos.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? CmodelosModel.fromJson(res.first) : null;
  }

  Future<MarcasModel> getMarcasId(int id) async {
    final db = await database;

    final res = await db.query(CMarcas.table,
        where: '${CMarcas.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? MarcasModel.fromJson(res.first) : null;
  }

  Future<ConectividadModel> getConectividadId(int id) async {
    final db = await database;

    final res = await db.query(CConectividades.table,
        where: '${CConectividades.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? ConectividadModel.fromJson(res.first) : null;
  }

  Future<Softwaremodel> getSoftwareId(int id) async {
    final db = await database;

    final res = await db.query(CSoftware.table,
        where: '${CSoftware.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? Softwaremodel.fromJson(res.first) : null;
  }

  Future<UnidadesModel> getUnidadId(int id) async {
    final db = await database;

    final res = await db.query(Bdunidades.table,
        where: '${Bdunidades.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res.isNotEmpty ? UnidadesModel.fromJson(res.first) : null;
  }

  Future<Odtmodel> getOdtsId(int id) async {
    final db = await database;
    final res = await db
        .query(BdArs.table, where: '${BdArs.columnID} = ?', whereArgs: [id]);
    return res.isNotEmpty ? Odtmodel.fromJson(res.first) : null;
  }

  Future<MovimientoInventarioSF> getMovInventarioSF(
      int idservicio, int idfalla) async {
    final db = await database;
    final res = await db.query(CmovimientoInventarioServicioFalla.table,
        where:
            '${CmovimientoInventarioServicioFalla.columnIDSERVICIO} = ? AND ${CmovimientoInventarioServicioFalla.columnIDFALLA} = ?',
        whereArgs: [idservicio, idfalla]);
    return res.isNotEmpty ? MovimientoInventarioSF.fromJson(res.first) : null;
  }

  Future<CCausasModel> getCausas(int idcausa) async {
    final db = await database;
    final res = await db.query(Causas.table,
        where: '${Causas.columnId} = ?', whereArgs: [idcausa]);
    return res.isNotEmpty ? CCausasModel.fromJson(res.first) : null;
  }

  Future<StatusCambioResponseModel> getCambioStatusResponse(int id) async {
    final db = await database;
    final res = await db.transaction((txn) async {
      var query = "SELECT ${BdCambioStatusAr.columnIDSTATUSARFIN} AS ID_STATUS_AR, "
      "(SELECT ${CstausAr.columnDESCSTATUSAR} FROM ${CstausAr.table} WHERE ${CstausAr.columnID} = ${BdCambioStatusAr.columnIDSTATUSARFIN}) AS DESC_STATUS_AR "
      "FROM ${BdCambioStatusAr.table} "
      "WHERE ${BdCambioStatusAr.columnIDSTATUSARINI} = $id";
      return txn.rawQuery(query);
    });
    return res.isNotEmpty ? StatusCambioResponseModel.fromJson(res.first) : null;
  }

  Future<UpdatesModel> getLastUpdate() async {
    final db = await database;
    final res =
        await db.query('$tableUpdates', orderBy: 'idupdates DESC', limit: 1);
    return res.isNotEmpty ? UpdatesModel.fromJson(res.first) : null;
  }

  //Seleccionar Todos
  Future<List<ServiciosModel>> getAllServicio() async {
    final db = await database;
    final res = await db.query(Cservicios.table);

    List<ServiciosModel> list = res.isNotEmpty
        ? res.map((s) => ServiciosModel.fromJson(s)).toList()
        : [];
    // await db.close();
    return list;
  }

  Future<List<FallasModel>> getAllFallas() async {
    final db = await database;

    final res = await db.transaction((txn) async {
      return await txn.query(Cfallas.table);
    });
    List<FallasModel> list =
        res.isNotEmpty ? res.map((s) => FallasModel.fromJson(s)).toList() : [];
    return list;
  }

  Future<List<CmodelosModel>> getAllModelos() async {
    final db = await database;
    final res = await db.query(CModelos.table);

    List<CmodelosModel> list = res.isNotEmpty
        ? res.map((s) => CmodelosModel.fromJson(s)).toList()
        : [];
    // await db.close();
    return list;
  }

  Future<List<MarcasModel>> getAllMarcas() async {
    final db = await database;
    final res = await db.query(CMarcas.table);

    List<MarcasModel> list =
        res.isNotEmpty ? res.map((s) => MarcasModel.fromJson(s)).toList() : [];
    // await db.close();
    return list;
  }

  Future<List<ConectividadModel>> getAllConectividad() async {
    final db = await database;
    final res = await db.query(CConectividades.table);

    List<ConectividadModel> list = res.isNotEmpty
        ? res.map((s) => ConectividadModel.fromJson(s)).toList()
        : [];
    // await db.close();
    return list;
  }

  Future<List<Softwaremodel>> getAllSoftware() async {
    final db = await database;
    final res = await db.query(CSoftware.table);

    List<Softwaremodel> list = res.isNotEmpty
        ? res.map((s) => Softwaremodel.fromJson(s)).toList()
        : [];
    // await db.close();
    return list;
  }

  Future<List<UnidadesModel>> getAllUnidades() async {
    final db = await database;
    final res = await db.query(Bdunidades.table);

    List<UnidadesModel> list = res.isNotEmpty
        ? res.map((s) => UnidadesModel.fromJson(s)).toList()
        : [];
    // await db.close();
    return list;
  }

  Future<List<MovimientoInventarioSF>> getAllMovimientoInventarioSF() async {
    final db = await database;
    final res = await db.query(CmovimientoInventarioServicioFalla.table);
    List<MovimientoInventarioSF> list = res.isNotEmpty
        ? res.map((s) => MovimientoInventarioSF.fromJson(s)).toList()
        : [];
    return list;
  }

  Future<List<CCausasModel>> getAllCausas() async {
    final db = await database;
    final res = await db.query(Causas.table);
    List<CCausasModel> list =
        res.isNotEmpty ? res.map((s) => CCausasModel.fromJson(s)).toList() : [];
    return list;
  }

  Future<List<Odtmodel>> getAllArs(int idstatus) async {
    final db = await database;
    final res = await db.transaction((txn) async {
      return await txn.rawQuery(
        "SELECT * , (SELECT ${Cfallas.columnDESCFALLA} "
                  "FROM ${Cfallas.table} "
                  "WHERE ${Cfallas.columnIDFALLA} = ${BdArs.columnIDFALLA}) AS DESC_FALLA, "
                  "(SELECT ${Cservicios.columnDESCSERVICIO} "
                  "FROM ${Cservicios.table} "
                  "WHERE ${Cservicios.columnID} = ${BdArs.columnIDSERVICIO}) AS DESC_SERVICIO "
                  "FROM ${BdArs.table} "
                  "WHERE ${BdArs.columnIDSTATUSAR} IN ($idstatus)"
      );
    });
    List<Odtmodel> list =
        res.isNotEmpty ? res.map((s) => Odtmodel.fromJson(s)).toList() : [];
    return list;
  }

  Future<List<Odtmodel>> getAllArsGroupByDate() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT ${BdArs.columnDAYS}, ${BdArs.columnMONTHS}, ${BdArs.columnYEARS} FROM ${BdArs.table} GROUP BY ${BdArs.columnDAYS}, ${BdArs.columnMONTHS}, ${BdArs.columnYEARS}");
    List<Odtmodel> list =
        res.isNotEmpty ? res.map((s) => Odtmodel.fromJson(s)).toList() : [];
    return list;
  }

  Future<List<Odtmodel>> getAllArsbyDate(
      int day, int month, int year, List<int> idstatus) async {
    final db = await database;
    String listaStatus = '';
    for (var id in idstatus) {
      listaStatus += id.toString() + ",";
    }

    String s = listaStatus.substring(0, listaStatus.length - 1);
/*
    final res = await db.query(BdArs.table,
        where:
            "${BdArs.columnDAYS} = ? AND ${BdArs.columnMONTHS} = ? AND ${BdArs.columnYEARS} = ? AND ${BdArs.columnIDSTATUSAR} IN ($s)",
        whereArgs: [day, month, year]);
*/
    final res = await db.transaction((txn) async {
      return await txn.rawQuery("SELECT * , (SELECT ${Cfallas.columnDESCFALLA} "
          "FROM ${Cfallas.table} "
          "WHERE ${Cfallas.columnIDFALLA} = ${BdArs.columnIDFALLA}) AS DESC_FALLA, "
          "(SELECT ${Cservicios.columnDESCSERVICIO} "
          "FROM ${Cservicios.table} "
          "WHERE ${Cservicios.columnID} = ${BdArs.columnIDSERVICIO}) AS DESC_SERVICIO "
          "FROM ${BdArs.table} "
          "WHERE ${BdArs.columnDAYS} = $day "
          "AND ${BdArs.columnMONTHS} = $month "
          "AND ${BdArs.columnYEARS} = $year "
          "AND ${BdArs.columnIDSTATUSAR} IN ($s)");
    });

    List<Odtmodel> list =
        res.isNotEmpty ? res.map((s) => Odtmodel.fromJson(s)).toList() : [];
    return list;
  }

  Future<TotalodtsModel> getTotalOdts() async {
    //Agregar el ID del estatus ar para realizar el conteo
    final db = await database;
    final total = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM ${BdArs.table} WHERE ${BdArs.columnIDSTATUSAR} = 13'));
    TotalodtsModel model = new TotalodtsModel();
    model.nuevas = total;
    return model;
  }

  //Actualizar
  Future<int> updateServicio(ServiciosModel nuevoServicio) async {
    final db = await database;
    final res = await db.update(Cservicios.table, nuevoServicio.toJson(),
        where: '${Cservicios.columnID} = ?',
        whereArgs: [nuevoServicio.idServicio]);
    // await db.close();
    return res;
  }

  Future<int> updateOdt(int idar, int idstatusar, String descstatusar) async {
    final db = await database;
    final res = await db.rawUpdate(
        "UPDATE ${BdArs.table} SET ${BdArs.columnIDSTATUSAR} = $idstatusar, ${BdArs.columnSTATUSAR} = '$descstatusar' WHERE ${BdArs.columnID} = $idar");
    return res;
  }

  //Eliminar uno
  Future<int> deleteServicio(int id) async {
    final db = await database;
    final res = await db.delete(Cservicios.table,
        where: '${Cservicios.columnID} = ?', whereArgs: [id]);
    // await db.close();
    return res;
  }

  Future<int> deleteAr(int id) async {
    final db = await database;
    final res = await db
        .delete(BdArs.table, where: '${BdArs.columnID} = ?', whereArgs: [id]);
    return res;
  }
  //Validar Existencia

  Future<bool> validateOdt(Odtmodel model) async {
    final db = await database;
    final res = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM ${BdArs.table} WHERE ${BdArs.columnID} = ${model.idAr}"));
    if (res > 0) return true;
    return false;
  }

  //Eliminar todo
}
