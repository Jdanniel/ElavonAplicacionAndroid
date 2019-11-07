import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

class AgregarComentario extends StatefulWidget {
  @override
  _AgregarComentarioState createState() => _AgregarComentarioState();
}

class _AgregarComentarioState extends State<AgregarComentario> {
  final _formKey = GlobalKey<FormState>();
  final _textformfieldController = new TextEditingController();
  Odtmodel odt = new Odtmodel();
  OdtsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final odtData = ModalRoute.of(context).settings.arguments;
    bloc = Provider.odtsBloc(context);

    if (odtData != null) {
      odt = odtData;
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              _botonRegresar(context),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.white,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _textformfieldController,
                      maxLines: 10,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Agregar comentario...'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor agrega algo de texto';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              _botonEnviar(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonEnviar(BuildContext _context) {
    return RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          //Scaffold.of(_context).showSnackBar(SnackBar(content: Text("Procesing Data"),));
          print(_textformfieldController.text);
          enviarComnetario(_textformfieldController.text);
          _textformfieldController.text = '';
        }
      },
      child: Text("Enviar"),
    );
  }

  void enviarComnetario(String comentario) async {
    showCustomLoadingWidget(Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 1.0,
        ),
        Text("Enviando...")
      ],
    )));
    int r = await bloc.agregarComentario(odt.idAr, comentario);
    String msg = '';
    r == 1 ? msg = "Comentario agregado" : msg = "El comentario no se agrego";
    hideLoadingDialog();
    final snackbar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackbar);    
  }

  Widget _botonRegresar(BuildContext _context) {
    return Container(
        padding: EdgeInsets.only(left: 10.0, top: 25.0),
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _regresar(_context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Comentario",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  void _regresar(BuildContext _context) {
    Navigator.pop(_context);
  }
}
