import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:elavonappmovil/bloc/cierreSustitucion_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/ccausas_model.dart';
import 'package:elavonappmovil/models/cmodelos_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CierresSustitucion extends StatefulWidget {
  @override
  _CierresSustitucionState createState() => _CierresSustitucionState();
}

class _CierresSustitucionState extends State<CierresSustitucion> {

  CierresSustitucionBloc bloc;
  ProgressDialog pr;

  final GlobalKey<FormState> _formkey0 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey1 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey3 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey4 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey5 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey6 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey7 = new GlobalKey<FormState>();

  TextEditingController textVersion = new TextEditingController();
  TextEditingController textIdamex = new TextEditingController();
  TextEditingController textAfilAmex = new TextEditingController();
  TextEditingController textConcAmex = new TextEditingController();
  TextEditingController textTelefono1 = new TextEditingController();
  TextEditingController textTelefono2 = new TextEditingController();
  TextEditingController textFechaCierre = new TextEditingController();
  TextEditingController textAtiende = new TextEditingController();
  TextEditingController textVoBo = new TextEditingController();
  TextEditingController textComentarios = new TextEditingController();

  List<DropdownMenuItem<String>> listaAplicativos;
  List<DropdownMenuItem<String>> listaSeries;
  List<DropdownMenuItem<String>> listaConectividades;

  String valueNoSerie;
  String valueConectividad;
  String valueAplicativo;
  String valueTipoAtencion;

  bool switchBateria = true;
  bool switchEliminador = true;
  bool switchTapa = true;
  bool switchCableac = true;
  bool switchBase = true;
  bool switchNotificado = false;
  bool switchPromociones = false;
  bool switchDescargar = false;
  bool chkIsAmex = false;

  /*Variable de Retiro*/
  TextEditingController textNoSerieRetiro = new TextEditingController();
  TextEditingController textVersionRetiro = new TextEditingController();


  List<DropdownMenuItem<String>> listaConectividadesRetiros;
  List<DropdownMenuItem<String>> listaMarcasRetiros;
  List<DropdownMenuItem<String>> listaModeloRetiros;
  List<DropdownMenuItem<String>> listaAplicativosRetiros;
  List<DropdownMenuItem<String>> listaCausas;

  String valuesMarcaRetiros;
  String valuesModeloRetiros;
  String valuesConectividadRetiros;
  String valuesAplicativoRetiros;
  String valuesCausasRetiros;

  bool switchBateriaRetiro = true;
  bool switchEliminadorRetiro = true;
  bool switchTapaRetiro = true;
  bool switchCableacRetiro = true;
  bool switchBaseRetiro = true;

  /*Fin de variables de Retiro */

  int currentStep = 0;
  int totalSteps = 7;
  int radiodiscover = 0;

  bool iscomplete = false;

  @override
  void initState() {
    super.initState();
    initDropDownButtonSeries();
    initDropDownButtonConectividad();
    initDropDownButtonAplicativo();
    initDropDownButtonMarca();
    initDropDownButtonModelo();
    initDropDownButtonCausas();
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    _crearProgressDialog();
    bloc = Provider.cierresSustitucionBloc(context);
    bloc.getVersion != null ? textVersion.text = bloc.getVersion : textVersion.text = '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          children: <Widget>[
            iscomplete
                ? Expanded(
                    child: Center(
                      child: AlertDialog(
                        title: Text("Carga Terminada, Envio en proceso"),
                        content: Text("Hecho!"),
                        actions: <Widget>[
                          new FlatButton(
                            child: Text("Close"),
                            onPressed: () {
                              setState(() {
                                iscomplete = false;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Stepper(
                        physics: ClampingScrollPhysics(),
                        type: StepperType.horizontal,
                        steps: [
                          paso0(),
                          paso1(),
                          paso2(),
                          paso3(),
                          paso4(),
                          paso5(),
                          paso6()
                        ],
                        currentStep: currentStep,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                        onStepContinue: next,
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
                          return botonesStepper(onStepContinue, onStepCancel);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Step paso0() {
    return Step(
        title: Text("1"),
        isActive: currentStep > 0 ? true : false,
        state: currentStep > 0 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey0,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Terminal a Instalar",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                _crearDropDownButtonSerie(),
                SizedBox(
                  height: 15.0,
                ),
                _crearDropDownButtonConectividad(),
                SizedBox(
                  height: 15.0,
                ),
                _crearDropDownButtonAplicativo(),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: textVersion,
                  decoration: InputDecoration(
                      // icon: Icon(Icons.gamepad),
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
            )));
  }

  Step paso1() {
    return Step(
        title: Text("2"),
        isActive: currentStep > 1 ? true : false,
        state: currentStep > 1 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey1,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Accesorios a Instalar",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                        value: switchCableac,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeCableAc(value);
                            switchCableac = value;
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
            )));
  }

  Step paso2() {
    return Step(
        title: Text("3"),
        isActive: currentStep > 2 ? true : false,
        state: currentStep > 2 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey2,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Datos AMEX",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Es Amex'),
                    Checkbox(
                      value: chkIsAmex,
                      onChanged: (value) {
                        setState(() {
                          bloc.changeIsAmex(value);
                          chkIsAmex = value;
                        });
                      },
                    ),
                  ],
                ),
                chkIsAmex
                    ? TextFormField(
                        controller: textIdamex,
                        decoration: InputDecoration(
                            //icon: Icon(Icons.gamepad),
                            labelText: 'Id Amex',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (newValue) {
                          setState(() {
                            bloc.changeIdAmex(newValue);
                          });
                        },
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
                        controller: textAfilAmex,
                        decoration: InputDecoration(
                            //icon: Icon(Icons.gamepad),
                            labelText: 'Afiliación Amex',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (newValue) {
                          setState(() {
                            bloc.changeAfilAmex(newValue);
                          });
                        },
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
                        controller: textConcAmex,
                        decoration: InputDecoration(
                            //icon: Icon(Icons.gamepad),
                            labelText: 'Conclusiones Amex',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (newValue) {
                          setState(() {
                            bloc.changeConclusionesAmex(newValue);
                          });
                        },
                        keyboardType: TextInputType.text,
                      )
                    : Container(),
              ],
            )));
  }

  Step paso3() {
    return Step(
        title: Text("4"),
        isActive: currentStep > 3 ? true : false,
        state: currentStep > 3 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey3,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Terminal a retirar",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: textNoSerieRetiro,
                  decoration: InputDecoration(
                      //icon: Icon(Icons.plus_one),
                      labelText: 'No Serie',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (newValue) {
                    setState(() {
                      bloc.changeNoserieRetiro(newValue);
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                SizedBox(
                  height: 8.0,
                ),
                _crearDropDownButtonMarcaRetiros(),
                SizedBox(
                  height: 8.0,
                ),
                _crearDropDownButtonModeloRetiros(),
                SizedBox(
                  height: 8.0,
                ),
                _crearDropDownButtonConectividadRetiros(),
                SizedBox(
                  height: 8.0,
                ),
                _crearDropDownButtonAplicativoRetiros(),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: textVersionRetiro,
                  decoration: InputDecoration(
                      //icon: Icon(Icons.plus_one),
                      labelText: 'Versión',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (newValue) {
                    setState(() {
                      bloc.changeVersionRetiro(newValue);
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ],
            )));
  }

  Step paso4() {
    return Step(
        title: Text("5"),
        isActive: currentStep > 4 ? true : false,
        state: currentStep > 4 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey4,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Accesorios a retirar",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Text(
                        "Batería",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchBateriaRetiro,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeBateriaRetiro(value);
                            switchBateriaRetiro = value;
                          });
                        },
                      ),
                      Text(
                        "Eliminador",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchEliminadorRetiro,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeEliminadorRetiro(value);
                            switchEliminadorRetiro = value;
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
                        value: switchTapaRetiro,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeTapaRetiro(value);
                            switchTapaRetiro = value;
                          });
                        },
                      ),
                      Text(
                        "Cable Ac",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchCableacRetiro,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeCableAcRetiro(value);
                            switchCableacRetiro = value;
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
                        value: switchBaseRetiro,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeBaseRetiro(value);
                            switchBaseRetiro = value;
                          });
                        },
                      ),
                      Container(),
                      Container(),
                    ])
                  ],
                ),
              ],
            )));
  }

  Step paso5() {
    return Step(
        title: Text("6"),
        isActive: currentStep > 5 ? true : false,
        state: currentStep > 5 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey5,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Mi Comercio",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Text(
                        "Notificado",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchNotificado,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeNotificado(value);
                            switchNotificado = value;
                          });
                        },
                      ),
                      Text(
                        "Promociones",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchPromociones,
                        onChanged: (value) {
                          setState(() {
                            bloc.changePromociones(value);
                            switchPromociones = value;
                          });
                        },
                      ),
                      Text(
                        "Se Descarga APP",
                        textAlign: TextAlign.right,
                      ),
                      Switch(
                        value: switchDescargar,
                        onChanged: (value) {
                          setState(() {
                            bloc.changeDescargarApp(value);
                            switchDescargar = value;
                          });
                        },
                      ),
                    ]),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: textTelefono1,
                  decoration: InputDecoration(
                      // icon: Icon(Icons.gamepad),
                      labelText: 'Teléfono 1',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (newValue) {
                    setState(() {
                      bloc.changeTelefono1(newValue);
                    });
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: textTelefono2,
                  decoration: InputDecoration(
                      // icon: Icon(Icons.gamepad),
                      labelText: 'Teléfono 2',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (newValue) {
                    setState(() {
                      bloc.changeTelefono2(newValue);
                    });
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 15.0,
                )
              ],
            )));
  }

  Step paso6() {
    return Step(
        title: Text("7"),
        isActive: currentStep > 6 ? true : false,
        state: currentStep > 6 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey6,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Datos del Servicio",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: textAtiende,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Atiende',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (value) {
                    setState(() {
                      bloc.changeAtiende(value);
                    });
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: textVoBo,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Otorgante VOBO',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (value) {
                    setState(() {
                      bloc.changeOtorgante(value);
                    });
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15.0,
                ),
                _crearDropDownButtonTipoAtencion(),
                /*Agregar tabla de C_CAUSAS para tomar el criterio de cambio */
                SizedBox(
                  height: 15.0,
                ),
                _crearDropDownButtonCausas(),
                SizedBox(
                  height: 15.0,
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
                          bloc.changeDiscover(value);
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
                          bloc.changeDiscover(value);
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
                SizedBox(
                  height: 25.0,
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
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Text(
                    "Comentarios Servicio",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
            )));
  }

  Step paso7() {
    return Step(
        title: Text("8"),
        isActive: currentStep > 7 ? true : false,
        state: currentStep > 7 ? StepState.complete : StepState.editing,
        content: Form(
            key: _formkey7,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Comentarios Servicio",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                      //bloc.changeComentarios(value);
                    });
                  },
                  keyboardType: TextInputType.multiline,
                ),
              ],
            )));
  }

  Widget botonesStepper(VoidCallback continues, VoidCallback cancel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0)),
                side: BorderSide(color: Theme.of(context).primaryColor)),
            child: Text("Regresar"),
            onPressed: cancel,
          ),
        ),
        Expanded(
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
              ),
            ),
            child: Text("Siguiente"),
            onPressed: () {
              if (validaBotonSiguiente()) {
                continues();
              }
            },
          ),
        )
      ],
    );
  }

  bool validaBotonSiguiente() {
    bool validate = false;
    switch (currentStep) {
      case 0:
        if (_formkey0.currentState.validate()) {
          validate = true;
        }
        break;
      case 1:
        if (_formkey1.currentState.validate()) {
          validate = true;
        }
        break;
      case 2:
        if (_formkey2.currentState.validate()) {
          validate = true;
        }
        break;
      case 3:
        if (_formkey3.currentState.validate()) {
          validate = true;
        }
        break;
      case 4:
        if (_formkey4.currentState.validate()) {
          validate = true;
        }
        break;
      case 5:
        if (_formkey5.currentState.validate()) {
          validate = true;
        }
        break;
      case 6:
        if (_formkey6.currentState.validate()) {
          validate = true;
        }
        break;
      default:
        validate = false;
        break;
    }
    return validate;
  }

  Widget _crearDropDownButtonSerie() {
    return DropdownButtonFormField(
      items: listaSeries,
      value: valueNoSerie,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeNoserie(newvalue);
          valueNoSerie = newvalue;
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'No Serie'),
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

  DropdownMenuItem<String> getDropDownWidgetSeries(UnidadesModel model) {
    return DropdownMenuItem<String>(
      value: model.noSerie,
      child: Text(
        model.noSerie,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }

  Widget _crearDropDownButtonCausas() {
    return DropdownButtonFormField(
      items: listaCausas,
      value: valuesCausasRetiros,
      onChanged: (newValue) {
        setState(() {
          bloc.changeCausas(newValue);
          valuesCausasRetiros = newValue;
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Causas'),
    );
  }

  initDropDownButtonCausas() {
    listaCausas = [];
    DBProvider.db.getAllCausas().then((causas) {
      causas.map((map) {
        return getDropDownWidgetCausas(map);
      }).forEach((dropdownitem) {
        listaCausas.add(dropdownitem);
      });
      setState(() {});
    });
  }

  getDropDownWidgetCausas(CCausasModel model) {
    return DropdownMenuItem<String>(
      value: model.descCausa,
      child: SizedBox(
        child: Text(
          model.descCausa.trimRight(),
          style: TextStyle(fontSize: 12.0),
        ),
        width: 200.0,
      ),
    );
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

  Widget _crearDropDownButtonConectividad() {
    return DropdownButtonFormField(
      items: listaConectividades,
      value: valueConectividad,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeConectividad(newvalue);
          valueConectividad = newvalue;
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Conectividad'),
    );
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

  Widget _crearDropDownButtonAplicativo() {
    return DropdownButtonFormField(
      items: listaAplicativos,
      value: valueAplicativo,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeAplicativo(newvalue);
          valueAplicativo = newvalue;
        });
      },
      decoration: InputDecoration(
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
          bloc.changeTipoAtencion(newValue);
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

  /*DropDownButtons Retiros */

  initDropDownButtonMarca() {
    listaMarcasRetiros = [];
    DBProvider.db.getAllMarcas().then((marcas) {
      marcas.map((map) {
        return getDropDownWidgetMarcas(map);
      }).forEach((dropdownItem) {
        listaMarcasRetiros.add(dropdownItem);
      });
      setState(() {});
    });
  }

  initDropDownButtonModelo() {
    listaModeloRetiros = [];
    DBProvider.db.getAllModelos().then((modelos) {
      modelos.map((map) {
        return getDropDownWidgetModelos(map);
      }).forEach((dropdownItem) {
        listaModeloRetiros.add(dropdownItem);
      });
      setState(() {});
    });
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

  Widget _crearDropDownButtonMarcaRetiros() {
    return DropdownButtonFormField(
      items: listaMarcasRetiros,
      value: valuesMarcaRetiros,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeMarcaRetiro(newvalue);
          valuesMarcaRetiros = newvalue;
        });
      },
      decoration: InputDecoration(
          //icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Marca'),
    );
  }

  Widget _crearDropDownButtonModeloRetiros() {
    return DropdownButtonFormField(
      items: listaModeloRetiros,
      value: valuesModeloRetiros,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeModeloRetiro(newvalue);
          valuesModeloRetiros = newvalue;
        });
      },
      decoration: InputDecoration(
          //icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Modelo'),
    );
  }

  Widget _crearDropDownButtonAplicativoRetiros() {
    return DropdownButtonFormField(
      items: listaAplicativos,
      value: valuesAplicativoRetiros,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeAplicativoRetiro(newvalue);
          valuesAplicativoRetiros = newvalue;
        });
      },
      decoration: InputDecoration(
          //icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Aplicativo'),
    );
  }

  Widget _crearDropDownButtonConectividadRetiros() {
    return DropdownButtonFormField(
      items: listaConectividades,
      value: valuesConectividadRetiros,
      onChanged: (newvalue) {
        setState(() {
          bloc.changeConectividadRetiro(newvalue);
          valuesConectividadRetiros = newvalue;
        });
      },
      decoration: InputDecoration(
          //icon: Icon(Icons.cast_connected),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Conectividad'),
    );
  }

  /*Fin DropDownButtons Retiro*/

  next() {
    currentStep + 1 != totalSteps
        ? goTo(currentStep + 1)
        : setState(() => iscomplete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  _crearProgressDialog() {
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

  _enviarSustitucion(){
    pr.show();

  }
}
