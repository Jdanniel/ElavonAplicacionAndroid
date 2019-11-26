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
              SizedBox(height: 15.0,),
              _crearDropDownButtonAplicativo(),
              SizedBox(height: 15.0,),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.gamepad),
                    labelText: 'Versión',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Text('Accesorios',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Batería"),
                  Switch(
                    value: tswitch,
                    onChanged: (value) {
                      setState(() {
                        tswitch = value;
                      });
                    },
                  ),
                  Text("Batería"),
                  Switch(
                    value: tswitch,
                    onChanged: (value) {
                      setState(() {
                        tswitch = value;
                      });
                    },
                  )
                ],
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
              ),
              SizedBox(
                height: 10.0,
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

  initDropDownButtonConectividad(){
    listaConectividades = [];
    DBProvider.db.getAllConectividad().then((conectividades){
      conectividades.map((map){
        return getDropDownWidgetConectividades(map);
      }).forEach((dropdownItem){
        listaConectividades.add(dropdownItem);
      });
      setState(() {});
    });
  }

  initDropDownButtonAplicativo(){
    listaAplicativos = [];
    DBProvider.db.getAllSoftware().then((softwares){
      softwares.map((map){
        return getDropDownWidgetAplicativos(map);
      }).forEach((dropdownItem){
        listaAplicativos.add(dropdownItem);
      });
      setState(() {});
    });
  }

  DropdownMenuItem<String> getDropDownWidgetSeries(UnidadesModel model) {
    return DropdownMenuItem<String>(
      value: model.noSerie,
      child: Text(model.noSerie, style: TextStyle(fontSize: 12.0),),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetConectividades(ConectividadModel model){
    return DropdownMenuItem<String>(
      value: model.descConectividad,
      child: SizedBox(child: Text(model.descConectividad.trimRight(), style: TextStyle(fontSize: 12.0),), width: 200.0,),
    );
  }

  DropdownMenuItem<String> getDropDownWidgetAplicativos(Softwaremodel model){
    return DropdownMenuItem<String>(
      value: model.descSoftware,
      child: SizedBox(child: Text(model.descSoftware.trimRight(), style: TextStyle(fontSize: 12.0),), width: 200.0,),
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
