import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Cierres extends StatefulWidget {
  @override
  _CierresState createState() => _CierresState();
}

class _CierresState extends State<Cierres> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  ProgressDialog pr;

  List<DropdownMenuItem<String>> listaAplicativos;
  List<DropdownMenuItem<String>> listaSeries;
  List<DropdownMenuItem<String>> listaConectividades;

  String valueNoSerie;
  String valueConectividad;
  String valueAplicativo;
  String valueTipoAtencion;
  String valueAbc;

  bool switchBateria = true;
  bool switchEliminador = true;
  bool switchTapa = true;
  bool switchCableac = true;
  bool switchBase = true;
  bool switchNotificado = true;
  bool switchPromociones = true;
  bool switchDescargar = true;
  bool chkIsAmex = false;

  int radiodiscover = 0;

  @override
  void initState() {
    super.initState();

    initDropDownButtonSeries();
    initDropDownButtonConectividad();
    initDropDownButtonAplicativo();
    
  }

  @override
  Widget build(BuildContext context) {
    //pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    createProgressDialog();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  "Terminal a Instalar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              _crearDropDownButtonSerie(),
              SizedBox(height: 15.0),
              _crearDropDownButtonConectividad(),
              SizedBox(
                height: 15.0,
              ),
              _crearDropDownButtonAplicativo(),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.gamepad),
                    labelText: 'Versión',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Text(
                  'Accesorios',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text("Batería"),
                  Switch(
                    value: switchBateria,
                    onChanged: (value) {
                      setState(() {
                        switchBateria = value;
                      });
                    },
                  ),
                  Text("Eliminador"),
                  Switch(
                    value: switchEliminador,
                    onChanged: (value) {
                      setState(() {
                        switchEliminador = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Tapa"),
                  Switch(
                    value: switchTapa,
                    onChanged: (value) {
                      setState(() {
                        switchTapa = value;
                      });
                    },
                  ),
                  Text("Cable Ac"),
                  Switch(
                    value: switchCableac,
                    onChanged: (value) {
                      setState(() {
                        switchCableac = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Base"),
                  Switch(
                    value: switchBase,
                    onChanged: (value) {
                      setState(() {
                        switchBase = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Text(
                  'Datos Amex',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text('Es Amex'),
                  Checkbox(
                    value: chkIsAmex,
                    onChanged: (value) {
                      setState(() {
                        chkIsAmex = value;
                      });
                    },
                  ),
                ],
              ),
              chkIsAmex
                  ? TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.gamepad),
                          labelText: 'Id Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      keyboardType: TextInputType.numberWithOptions(),
                    )
                  : Container(),
              chkIsAmex
                  ? SizedBox(
                      height: 15.0,
                    )
                  : Container(),
              chkIsAmex
                  ? TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.gamepad),
                          labelText: 'Afiliación Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      keyboardType: TextInputType.numberWithOptions(),
                    )
                  : Container(),
              chkIsAmex
                  ? SizedBox(
                      height: 15.0,
                    )
                  : Container(),
              chkIsAmex
                  ? TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.gamepad),
                          labelText: 'Conclusiones Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      keyboardType: TextInputType.text,
                    )
                  : Container(),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  'Mi Comercio',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: <Widget>[
                  Text("Notificado"),
                  Switch(
                    value: switchNotificado,
                    onChanged: (value) {
                      setState(() {
                        switchNotificado = value;
                      });
                    },
                  ),
                  Text("Promociones"),
                  Switch(
                    value: switchPromociones,
                    onChanged: (value) {
                      setState(() {
                        switchPromociones = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Se Descarga App"),
                  Switch(
                    value: switchDescargar,
                    onChanged: (value) {
                      setState(() {
                        switchDescargar = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Teléfono 1',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Teléfono 2',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  'Datos del Servicio',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              DateTimeField(
                format: DateFormat('dd/MM/yyyy'),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Fecha Cierre',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Atiende',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Otorgante VOBO',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 15.0,
              ),
              _crearDropDownButtonTipoAtencion(),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Rollos Instalados',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Discover',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: radiodiscover,
                    onChanged: (value) {
                      setState(() {
                        radiodiscover = value;
                      });
                    },
                  ),
                  Text(
                    'Sí',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: 0,
                    groupValue: radiodiscover,
                    onChanged: (value) {
                      setState(() {
                        radiodiscover = value;
                      });
                    },
                  ),
                  Text(
                    'No',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Discover'),
                  Checkbox(
                    value: chkIsAmex,
                    onChanged: (value) {
                      setState(() {
                        chkIsAmex = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Caja',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  'Comentarios Servicio',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    labelText: 'Comentarios',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.multiline,
              ),
              RaisedButton(
                child: Text('Prueba'),
                onPressed: () {
                  pr.show();
                  Future.delayed(Duration(seconds: 10)).then((value){
                    pr.hide().whenComplete((){
                      Navigator.pop(context);
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  createProgressDialog() {
    pr.style(
        message: 'Enviando Datos',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  initDropDownButtonSeries() {
    listaSeries = [];
    DBProvider.db.getAllUnidades().then((unidades) {
      unidades.map((map) {
        return getDropDownWidgetSeries(map);
      }).forEach((dropdownitem) {
        listaSeries.add(dropdownitem);
      });
      setState(() {});
    });
  }

  initDropDownButtonConectividad() {
    listaConectividades = [];
    DBProvider.db.getAllConectividad().then((conectividades) {
      conectividades.map((map) {
        return getDropDownWidgetConectividades(map);
      }).forEach((dropdownItem) {
        listaConectividades.add(dropdownItem);
      });
      setState(() {});
    });
  }

  initDropDownButtonAplicativo() {
    listaAplicativos = [];
    DBProvider.db.getAllSoftware().then((softwares) {
      softwares.map((map) {
        return getDropDownWidgetAplicativos(map);
      }).forEach((dropdownItem) {
        listaAplicativos.add(dropdownItem);
      });
      setState(() {});
    });
  }

  DropdownMenuItem<String> getDropDownWidgetSeries(UnidadesModel model) {
    return DropdownMenuItem<String>(
      value: model.noSerie,
      child: Text(
        model.noSerie,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetConectividades(
      ConectividadModel model) {
    return DropdownMenuItem<String>(
      value: model.descConectividad,
      child: SizedBox(
        child: Text(
          model.descConectividad.trimRight(),
          style: TextStyle(fontSize: 12.0),
        ),
        width: 200.0,
      ),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetAplicativos(Softwaremodel model) {
    return DropdownMenuItem<String>(
      value: model.descSoftware,
      child: SizedBox(
        child: Text(
          model.descSoftware.trimRight(),
          style: TextStyle(fontSize: 12.0),
        ),
        width: 200.0,
      ),
    );
  }

  Widget _crearDropDownButtonSerie() {
    return DropdownButtonFormField(
      items: listaSeries,
      value: valueNoSerie,
      onChanged: (newvalue) {
        setState(() {
          valueNoSerie = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.confirmation_number),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'No Serie'),
    );
  }

  Widget _crearDropDownButtonConectividad() {
    return DropdownButtonFormField(
      items: listaConectividades,
      value: valueConectividad,
      onChanged: (newvalue) {
        setState(() {
          valueConectividad = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Conectividad'),
    );
  }

  Widget _crearDropDownButtonAplicativo() {
    return DropdownButtonFormField(
      items: listaAplicativos,
      value: valueAplicativo,
      onChanged: (newvalue) {
        setState(() {
          valueAplicativo = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.settings_applications),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Aplicativo'),
    );
  }

  Widget _crearDropDownButtonTipoAtencion() {
    List<DropdownMenuItem<String>> datos;
    datos = [];
    DropdownMenuItem<String> a = new DropdownMenuItem<String>(
      value: 'Llamada de Validación',
      child: Text(
        'Llamada de Validación',
        style: TextStyle(fontSize: 12.0),
      ),
    );
    datos.add(a);
    DropdownMenuItem<String> b = new DropdownMenuItem<String>(
      value: 'Presencial',
      child: Text(
        'Presencial',
        style: TextStyle(fontSize: 12.0),
      ),
    );
    datos.add(b);

    return DropdownButtonFormField(
      items: datos,
      value: valueTipoAtencion,
      onChanged: (newValue) {
        setState(() {
          valueTipoAtencion = newValue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.confirmation_number),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Tipo de Atención'),
    );
  }
}
