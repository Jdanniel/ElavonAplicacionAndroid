import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Cierres extends StatefulWidget {
  @override
  _CierresState createState() => _CierresState();
}

class _CierresState extends State<Cierres> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  List<DropdownMenuItem<String>> listaAplicativos;
  List<DropdownMenuItem<String>> listaSeries;
  List<DropdownMenuItem<String>> listaConectividades;

  String valueNoSerie;
  String valueConectividad;
  String valueAplicativo;
  String valueAbc;

  bool switchBateria = true;
  bool switchEliminador = true;
  bool switchTapa = true;
  bool switchCableac = true;
  bool switchBase = true;
  bool chkIsAmex = false;

  bool tswitch = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDropDownButtonSeries();
    initDropDownButtonConectividad();
    initDropDownButtonAplicativo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Text(
                  "Terminal a Instalar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
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
                      height: 5.0,
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
                      height: 5.0,
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
                height: 5.0,
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
                    value: switchBase,
                    onChanged: (value) {
                      setState(() {
                        switchBase = value;
                      });
                    },
                  ),
                  Text("Promociones"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Se Descarga App"),
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
                height: 5.0,
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
                height: 5.0,
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
                    labelText: 'Fecha Cierre',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(
                height: 5.0,
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
                height: 5.0,
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
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Tipo de Atención"),
                  Switch(
                    value: switchBase,
                    onChanged: (value) {
                      setState(() {
                        switchBase = value;
                      });
                    },
                  ),
                  Text("Técnico"),
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
                height: 5.0,
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
                height: 5.0,
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
            ],
          ),
        ),
      ),
    );
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
          icon: Icon(Icons.confirmation_number),
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
          icon: Icon(Icons.confirmation_number),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Aplicativo'),
    );
  }
}
