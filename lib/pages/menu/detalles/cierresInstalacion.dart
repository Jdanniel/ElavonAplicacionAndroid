import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/cierresInstalacionrequest_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';


class CierresInstalacion extends StatefulWidget {
  @override
  _CierresInstalacionState createState() => _CierresInstalacionState();
}

class _CierresInstalacionState extends State<CierresInstalacion> {
  
  final GlobalKey<FormState> _formKey0 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = new GlobalKey<FormState>();

  CierresInstalacionBloc bloc;

  ProgressDialog pr;

  TextEditingController textVersion = new TextEditingController();
  TextEditingController textIdamex = new TextEditingController();
  TextEditingController textAfilAmex = new TextEditingController();
  TextEditingController textConcAmex = new TextEditingController();
  TextEditingController textTelefono1 = new TextEditingController();
  TextEditingController textTelefono2 = new TextEditingController();
  TextEditingController textAtiende = new TextEditingController();
  TextEditingController textVOBO = new TextEditingController();
  TextEditingController textComentarios = new TextEditingController();
  TextEditingController textFechaCierre = new TextEditingController();

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
  bool isComplete = false;

  int radiodiscover = 0;
  int currentStep = 0;
  int totalSteps = 6;

  @override
  void initState() {
    super.initState();
    initDropDownButtonSeries();
    initDropDownButtonConectividad();
    initDropDownButtonAplicativo();
    
  }

  @override
  Widget build(BuildContext context) {
    
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    createProgressDialog();    

    bloc = Provider.cierresInstalBloc(context);
    bloc.getVersion != null ? textVersion.text = bloc.getVersion : textVersion.text = '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            isComplete ? Expanded(
              child: Center(
                child: AlertDialog(
                  title: Text("Datos ingresados"),
                  content: Text("¿Deseas Continuar?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Regresar"),
                      onPressed: (){
                        setState(() {
                          isComplete = false;
                        });
                      },
                    ),
                    FlatButton(
                      child: Text("Continuar"),
                      onPressed: (){
                        _enviarDatosCierreInstalacion();
                      },
                    )
                  ],
                ),
              ),
            ) : Expanded(
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
                    paso5()
                  ],
                  currentStep: currentStep,
                  onStepTapped: (step) => goTo(step),
                  onStepCancel: cancel,
                  onStepContinue: next,
                  controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
                    return _botonesStepper(onStepContinue, onStepCancel);
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _botonesStepper(VoidCallback continues, VoidCallback cancel){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                bottomLeft: Radius.circular(18.0)
              ),
              side: BorderSide(color: Theme.of(context).primaryColor)
            ),
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
                bottomRight: Radius.circular(18.0)
              ),
            ),
            child: Text("Siguiente"),
            onPressed: (){
              if(validaBotonSiguiente()){
                continues();
              }
            },
          ),
        )
      ],
    );
  }

  bool validaBotonSiguiente(){
    bool validate = false;
    switch(currentStep){
      case 0:
        if(_formKey0.currentState.validate()){
          validate = true;
        }
        break;
      case 1:
        if(_formKey1.currentState.validate()){
          validate = true;
        }
        break;
      case 2:
        if(_formKey2.currentState.validate()){
          validate = true;
        }
        break;
      case 3:
        if(_formKey3.currentState.validate()){
          validate = true;
        }
        break;
      case 4:
        if(_formKey4.currentState.validate()){
          validate = true;
        }
        break;
      case 5:
        if(_formKey5.currentState.validate()){
          validate = true;
        }
        break;
      default:
        validate = false;
        break;
    }
    return validate;
  }

  Step paso0(){
    return Step(
      title: Text("1"),
      isActive: currentStep > 0 ? true : false,
      state: currentStep > 0 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey0,
        child: Column(
          children: <Widget>[
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
                controller: textVersion,
                decoration: InputDecoration(
                    icon: Icon(Icons.gamepad),
                    labelText: 'Versión',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                onChanged: (newValue){
                  setState(() {
                    bloc.changeVersion(newValue);
                  });
                },
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 5.0,
              ),
          ],
        )
      )
    );
  }

  Step paso1(){
    return Step(
      title: Text("2"),
      isActive: currentStep > 1 ? true : false,
      state: currentStep > 1 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey1,
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
        )
      )
    );
  }

  Step paso2(){
    return Step(
      title: Text("2"),
      isActive: currentStep > 2 ? true : false,
      state: currentStep > 2 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey2,
        child: Column(
          children: <Widget>[
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
                          icon: Icon(Icons.gamepad),
                          labelText: 'Id Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (newValue){
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
                          icon: Icon(Icons.gamepad),
                          labelText: 'Afiliación Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                              onChanged: (newValue){
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
                          icon: Icon(Icons.gamepad),
                          labelText: 'Conclusiones Amex',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                              onChanged: (newValue){
                                setState(() {
                                  bloc.changeConclusionesAmex(newValue);
                                });
                              },
                      keyboardType: TextInputType.text,
                    )
                  : Container(),
              SizedBox(
                height: 15.0,
              ),
          ],
        )
      )
    );
  }

  Step paso3(){
    return Step(
      title: Text("3"),
      isActive: currentStep > 3  ? true : false,
      state: currentStep > 3 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey3,
        child: Column(
          children: <Widget>[
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
                        bloc.changeNotificado(value);
                        switchNotificado = value;
                      });
                    },
                  ),
                  Text("Promociones"),
                  Switch(
                    value: switchPromociones,
                    onChanged: (value) {
                      setState(() {
                        bloc.changePromociones(value);
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
                        bloc.changeDescargarApp(value);
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
                controller: textTelefono1,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Teléfono 1',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
                          setState(() {
                            bloc.changeTelefono1(value);
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
                    icon: Icon(Icons.phone),
                    labelText: 'Teléfono 2',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
                          setState(() {
                            bloc.changeTelefono2(value);
                          });
                        },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 15.0,
              ),
          ],
        )
      )
    );
  }

  Step paso4(){
    return Step(
      title: Text("4"),
      isActive: currentStep > 4 ? true : false,
      state: currentStep > 4 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey4,
        child: Column(
          children: <Widget>[
              Container(
                child: Text(
                  'Datos del Servicio',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
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
                  if(date != null){
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  }else{
                    return currentValue;
                  }

                },
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Fecha Cierre',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
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
                controller: textVOBO,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Otorgante VOBO',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
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
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.camera_roll),
                    labelText: 'Rollos Instalados',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
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
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Caja',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
                          setState(() {
                            bloc.changeCaja(int.parse(value));
                          });
                        },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15.0,
              ),
          ],
        )
      )
    );
  }

  Step paso5(){
    return Step(
      title: Text("5"),
      isActive: currentStep > 5 ? true : false,
      state: currentStep > 5 ? StepState.complete : StepState.editing,
      content: Form(
        key: _formKey5,
        child: Column(
          children: <Widget>[
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
                controller: textComentarios,
                maxLines: 5,
                decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    labelText: 'Comentarios',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                        onChanged: (value){
                          setState(() {
                            bloc.changeComentarios(value);
                          });
                        },
                keyboardType: TextInputType.multiline,
              ),
          ],
        )
      )
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
          bloc.changeNoserie(newvalue);
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
          bloc.changeConectividad(newvalue);
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
          bloc.changeAplicativo(newvalue);
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

  _enviarDatosCierreInstalacion(){
        pr.show();
        CierresInstalacionModel model = new CierresInstalacionModel();
        model.noSerie = bloc.getNoSerie;
        model.conectividad = bloc.getConectividad;
        model.aplicativo = bloc.getAplicativo;
        model.version = bloc.getVersion;
        model.bateria = bloc.getBateria == null ? true : bloc.getBateria;
        model.eliminador = bloc.getEliminador == null ? true: bloc.getEliminador;
        model.tapa = bloc.getTapa == null ? true : bloc.getTapa;
        model.cableAc = bloc.getCableAc == null ? true : bloc.getCableAc;
        model.base = bloc.getBase == null ? true : bloc.getBase;
        model.isAmex = bloc.getIsAmex == null ? false : bloc.getIsAmex;
        if(bloc.getIsAmex == true){
          model.idAmex = bloc.getIdAmex;
          model.afiliacionAmex = bloc.getAfilAmex;
          model.conclusionesAmex = bloc.getConclusionesAmex;
        }
        model.notificado = bloc.getNotificado == null ? true : bloc.getNotificado;
        model.promociones = bloc.getPromociones == null ? true : bloc.getPromociones;
        model.descargaApp = bloc.getDescargarApp == null ? true : bloc.getDescargarApp;
        model.telefono1 = bloc.getTelefono1;
        model.telefono2 = bloc.getTelefono2;
        model.fechaCierre = bloc.getFechaCierre;
        model.atiende = bloc.getAtiende;
        model.otorganteVobo = bloc.getOtorgante;
        model.tipoAtencion = bloc.getTipoAtencion;
        model.rollos = bloc.getRollos;
        model.discover = bloc.getDiscover == null ? 0 : bloc.getDiscover;
        model.caja = bloc.getCaja;
        model.comentario = bloc.getComentarios;
        print(model.discover);
        Future.delayed(Duration(seconds: 15)).then((value){
          pr.hide().whenComplete((){
            Navigator.pop(context);
          });
        });
  }

  next(){
    currentStep + 1 != totalSteps
                    ? goTo(currentStep + 1)
                    : setState(() => isComplete = true);
  }

  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }

  goTo(int step){
    setState(() {
      currentStep = step;
    });
  }
}
