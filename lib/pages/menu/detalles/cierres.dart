import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Cierres extends StatefulWidget {
  @override
  _CierresState createState() => _CierresState();
}

class _CierresState extends State<Cierres> {

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  String valueAbc;
  bool tswitch = true;

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
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Nombre',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                ),
              ),
              SizedBox(height: 5.0,),
              DropdownButtonFormField(
                items: getItems(),  
                value: valueAbc,
                onChanged: (newValue) {
                  setState(() {
                    valueAbc = newValue;
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person_outline),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              Row(
                children: <Widget>[
                  Text("Switch"),
                  Switch(
                    value: tswitch,
                    onChanged: (value){
                      setState(() {
                        tswitch = value;
                      });
                    },
                  )
                ],
              ),
              DateTimeField(
                format: DateFormat('dd/MM/yyyy'),
                onShowPicker: (context, currentValue){
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100)
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems(){
    final lista = new List<DropdownMenuItem>();
    for(int i = 0; i < 10; i++){
      DropdownMenuItem data = new DropdownMenuItem(child: Text('A$i'),value: 'A$i',);
      lista.add(data);
    }
    return lista; 
  }
}