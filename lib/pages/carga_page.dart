import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/updates_model.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CargaPage extends StatefulWidget {
  const CargaPage({Key key}) : super(key: key);

  @override
  _CargaPageState createState() => _CargaPageState();
}

class _CargaPageState extends State<CargaPage> {
  ProgressDialog pr;
  double progreso = 0.0;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false);
    _crearProgressDialog();
    valActualizarOdts(context);

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
        ),
      ),
    );
  }

  void valActualizarOdts(context) async {
    final updateBloc = Provider.updatesBloc(context);
    final update = await updateBloc.selectUpdate();

    if (update == null) {
      cargarCatalogos(context);
    } else {
      final odtBloc = Provider.odtsBloc(context);
      await odtBloc.getNuevasOdts(update.fecha);
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  _crearProgressDialog() {
    pr.style(
        message: 'Actualizando...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: progreso,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  _incremetarProgress(double i) {
    pr.update(
      progress: i,
      message: "Actualizando...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  void cargarCatalogos(BuildContext context) async {
    pr.show();

    final dn =
        formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
    final updatesBloc = Provider.updatesBloc(context);

    final serviciosBloc = Provider.serviciosBloc(context);
    await serviciosBloc.getServiciosHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final fallaBloc = Provider.fallasBloc(context);
    await fallaBloc.getFallasHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final modeloBloc = Provider.modelosBloc(context);
    await modeloBloc.getModelosHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final marcaBloc = Provider.marcasBloc(context);
    await marcaBloc.getMarcasHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final conectividadBloc = Provider.conectividadBloc(context);
    await conectividadBloc.getConectividadHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final softwareBloc = Provider.softwareBloc(context);
    await softwareBloc.getSoftwareHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final unidadBloc = Provider.unidadesBloc(context);
    await unidadBloc.getUnidadesHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final odtBloc = Provider.odtsBloc(context);
    await odtBloc.getAllOdtsHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final causasBloc = Provider.causasBloc(context);
    await causasBloc.getAllCausasHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);
    final movimientoBloc = Provider.movimientosInventarioBloc(context);
    await movimientoBloc.getAllMovimientosInventarioHttp();
    progreso+=10.0;
    _incremetarProgress(progreso);  
    final statusArBloc = Provider.statusArBloc(context);
    await statusArBloc.getAllStatusArHttp();
    progreso+= 10.0;
    _incremetarProgress(progreso);
    final cambioStatusAr = Provider.cambioStatusArBloc(context);
    await cambioStatusAr.getAllCambiosStatusArHttp();
    progreso+= 10.0;
    _incremetarProgress(progreso);
    final up = new UpdatesModel();
    up.fecha = dn;
    await updatesBloc.insertUpdates(up);
    pr.hide().whenComplete(() {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }
}
