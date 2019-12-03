import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/cierresRetiro_model.dart';
import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CierresRetiro extends StatefulWidget {
  @override
  _CierresRetiroState createState() => _CierresRetiroState();
}

class _CierresRetiroState extends State<CierresRetiro> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  CierresRetiroBloc bloc;

  ProgressDialog pr;

  List<DropdownMenuItem<String>> listaConectividades;
  List<DropdownMenuItem<String>> listaMarcas;
  List<DropdownMenuItem<String>> listaModelo;
  List<DropdownMenuItem<String>> listaAplicativos;

  TextEditingController textNoSerie = new TextEditingController();
  TextEditingController textVersion = new TextEditingController();
  TextEditingController textAtiende = new TextEditingController();
  TextEditingController textOtorganteVobo = new TextEditingController();
  TextEditingController textComentarios = new TextEditingController();
  TextEditingController textRollos = new TextEditingController();
  TextEditingController textCaja = new TextEditingController();
  TextEditingController textFechaCierre = new TextEditingController();

  String valuesMarca;
  String valuesModelo;
  String valuesConectividad;
  String valuesAplicativo;
  String valuesTipoAtencion;

  bool switchBateria = true;
  bool switchEliminador = true;
  bool switchTapa = true;
  bool switchCableAc = true;
  bool switchBase = true;

  int radioDiscover = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDropDownButtonAplicativo();
    initDropDownButtonConectividad();
    initDropDownButtonMarca();
    initDropDownButtonModelo();
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    createProgressDialog();    
    bloc = Provider.cierresRetiroBloc(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.only(top: 16.0, left: 16.0),
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Text(
                  "Terminal a Retirar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: textNoSerie,
                      decoration: InputDecoration(
                          icon: Icon(Icons.plus_one),
                          labelText: 'No Serie',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (newValue) {
                        setState(() {
                          bloc.changeNoserie(newValue);
                        });
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _crearDropDownButtonMarca(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _crearDropDownButtonModelo(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _crearDropDownButtonConectividad(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _crearDropDownButtonAplicativo(),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: textVersion,
                      decoration: InputDecoration(
                          icon: Icon(Icons.plus_one),
                          labelText: 'Versión',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (newValue) {
                        setState(() {
                          bloc.changeVersion(newValue);
                        });
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Text(
                  "Accesorios",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0))),
                  child: Column(
                    children: <Widget>[
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            Text(
                              "Batería",
                              textAlign: TextAlign.right,
                            ),
                            Switch(
                              value: switchBateria,
                              onChanged: (value) {
                                setState(() {
                                  bloc.changeBateria(value);
                                  switchBateria = value;
                                });
                              },
                            ),
                            Text(
                              "Eliminador",
                              textAlign: TextAlign.right,
                            ),
                            Switch(
                              value: switchEliminador,
                              onChanged: (value) {
                                setState(() {
                                  bloc.changeEliminador(value);
                                  switchEliminador = value;
                                });
                              },
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              "Tapa",
                              textAlign: TextAlign.right,
                            ),
                            Switch(
                              value: switchTapa,
                              onChanged: (value) {
                                setState(() {
                                  bloc.changeTapa(value);
                                  switchTapa = value;
                                });
                              },
                            ),
                            Text(
                              "Cable Ac",
                              textAlign: TextAlign.right,
                            ),
                            Switch(
                              value: switchCableAc,
                              onChanged: (value) {
                                setState(() {
                                  bloc.changeCableAc(value);
                                  switchCableAc = value;
                                });
                              },
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              "Base",
                              textAlign: TextAlign.right,
                            ),
                            Switch(
                              value: switchBase,
                              onChanged: (value) {
                                setState(() {
                                  bloc.changeBase(value);
                                  switchBase = value;
                                });
                              },
                            ),
                            Container(),
                            Container(),
                          ])
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Text(
                  "Datos del Servicio",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Column(
                  children: <Widget>[
                    DateTimeField(
                      controller: textFechaCierre,
                      format: DateFormat('dd/MM/yyyy HH:mm'),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: 'Fecha Cierre',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        setState(() {
                          bloc.changeFechaCierre(value);
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: textAtiende,
                      decoration: InputDecoration(
                          icon: Icon(Icons.plus_one),
                          labelText: 'Atiende',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (newValue) {
                        setState(() {
                          bloc.changeAtiende(newValue);
                        });
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: textOtorganteVobo,
                      decoration: InputDecoration(
                          icon: Icon(Icons.plus_one),
                          labelText: 'Otorgante VoBo',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (newValue) {
                        setState(() {
                          bloc.changeOtorgante(newValue);
                        });
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _crearDropDownButtonTipoAtencion(),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.camera_roll),
                          labelText: 'Rollos Instalados',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        setState(() {
                          bloc.changeRollos(int.parse(value));
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Discover',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: radioDiscover,
                          onChanged: (value) {
                            setState(() {
                              bloc.changeDiscover(value);
                              radioDiscover = value;
                            });
                          },
                        ),
                        Text(
                          'Sí',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 0,
                          groupValue: radioDiscover,
                          onChanged: (value) {
                            setState(() {
                              bloc.changeDiscover(value);
                              radioDiscover = value;
                            });
                          },
                        ),
                        Text(
                          'No',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Caja',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        setState(() {
                          bloc.changeCaja(int.parse(value));
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Text(
                  "Comentarios del Servicio",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0))),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: textComentarios,
                      maxLines: 5,
                      decoration: InputDecoration(
                          icon: Icon(Icons.text_fields),
                          labelText: 'Comentarios',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        setState(() {
                          bloc.changeComentarios(value);
                        });
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text('Enviar'),
                  onPressed: (){
                    _enviarCierreRetiro();
                  },
                ),
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

  _enviarCierreRetiro(){
    CierreRetiroModel model = new CierreRetiroModel();
    model.noSerie = bloc.getNoSerie;
    model.marca = bloc.getMarca;
    model.modelo = bloc.getModelo;
    model.conectividad = bloc.getConectividad;
    model.aplicativo = bloc.getAplicativo;
    model.version = bloc.getVersion;
    model.bateria = bloc.getBateria == null ? true : bloc.getBateria;
    model.eliminador = bloc.getEliminador == null ? true : bloc.getEliminador;
    model.tapa = bloc.getTapa == null ? true : bloc.getTapa;
    model.cableAc = bloc.getCableAc == null ? true : bloc.getCableAc;
    model.base = bloc.getBase == null ? true : bloc.getBase;
    model.fechaCierre = bloc.getFechaCierre;
    model.atiende = bloc.getAtiende;
    model.otorganteVobo = bloc.getOtorgante;
    model.tipoAtencion = bloc.getTipoAtencion;
    model.rollos = bloc.getRollos;
    model.discover = bloc.getDiscover == null ? 0 : bloc.getDiscover;
    model.caja = bloc.getCaja;
    model.comentario = bloc.getComentarios;
    Future.delayed(Duration(seconds: 15)).then((value){
      pr.hide().whenComplete((){
        Navigator.pop(context);
      });
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

  initDropDownButtonMarca() {
    listaMarcas = [];
    DBProvider.db.getAllMarcas().then((marcas) {
      marcas.map((map) {
        return getDropDownWidgetMarcas(map);
      }).forEach((dropdownItem) {
        listaMarcas.add(dropdownItem);
      });
      setState(() {});
    });
  }

  initDropDownButtonModelo() {
    listaModelo = [];
    DBProvider.db.getAllModelos().then((modelos) {
      modelos.map((map) {
        return getDropDownWidgetModelos(map);
      }).forEach((dropdownItem) {
        listaModelo.add(dropdownItem);
      });
      setState(() {});
    });
  }

  initDropDownButtonAplicativo() {
    listaAplicativos = [];
    DBProvider.db.getAllSoftware().then((software) {
      software.map((map) {
        return getDropDownWidgetAplicativo(map);
      }).forEach((dropdownItem) {
        listaAplicativos.add(dropdownItem);
      });
      setState(() {});
    });
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

  DropdownMenuItem<String> getDropDownWidgetMarcas(MarcasModel model) {
    return DropdownMenuItem<String>(
      value: model.descMarca,
      child: SizedBox(
        child: Text(
          model.descMarca.trimRight(),
          style: TextStyle(fontSize: 12.0),
        ),
        width: 200.0,
      ),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetModelos(CmodelosModel model) {
    return DropdownMenuItem<String>(
      value: model.descModelo,
      child: SizedBox(
        child: Text(
          model.descModelo.trimRight(),
          style: TextStyle(fontSize: 12.0),
        ),
        width: 200.0,
      ),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetAplicativo(Softwaremodel model) {
    return DropdownMenuItem<String>(
      value: model.descSoftware,
      child: SizedBox(
        child: Text(
          model.descSoftware.trimRight(),
          style: TextStyle(fontSize: 11.0),
        ),
      ),
    );
  }

  Widget _crearDropDownButtonConectividad() {
    return DropdownButtonFormField(
      items: listaConectividades,
      value: valuesConectividad,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeConectividad(newvalue);
          valuesConectividad = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Conectividad'),
    );
  }

  Widget _crearDropDownButtonMarca() {
    return DropdownButtonFormField(
      items: listaMarcas,
      value: valuesMarca,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeMarca(newvalue);
          valuesMarca = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Marca'),
    );
  }

  Widget _crearDropDownButtonModelo() {
    return DropdownButtonFormField(
      items: listaModelo,
      value: valuesModelo,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeModelo(newvalue);
          valuesModelo = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Modelo'),
    );
  }

  Widget _crearDropDownButtonAplicativo() {
    return DropdownButtonFormField(
      items: listaAplicativos,
      value: valuesAplicativo,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeAplicativo(newvalue);
          valuesAplicativo = newvalue;
        });
      },
      decoration: InputDecoration(
          icon: Icon(Icons.cast_connected),
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
      value: valuesTipoAtencion,
      onChanged: (newValue) {
        setState(() {
          bloc.changeTipoAtencion(newValue);
          valuesTipoAtencion = newValue;
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
