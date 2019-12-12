import 'dart:io';

import 'package:elavonappmovil/bloc/detalleinit_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load/load.dart';

class TomarFoto extends StatefulWidget {
  @override
  _TomarFotoState createState() => _TomarFotoState();
}

class _TomarFotoState extends State<TomarFoto> {
  File _image;
  bool _ismageloaded = false;
  OdtsBloc bloc;
  DetalleInitBloc detalleInitBloc;

  Odtmodel odt = new Odtmodel();

  int pageReturn = 0;

  @override
  Widget build(BuildContext context) {

    detalleInitBloc = Provider.detalleinitBloc(context);
    bloc = Provider.odtsBloc(context);

    odt = bloc.getNuevoOdt;
    pageReturn = detalleInitBloc.getPageReturn;

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
              Center(
                child: Container(
                  height: 250.0,
                  width: 250.0,
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: _ismageloaded
                            ? Image.file(_image)
                            : Text("Imagen")),
                  ),
                ),
              ),
              FlatButton.icon(
                color: Colors.white,
                icon: Icon(Icons.send),
                label: Text('Enviar'),
                onPressed: () {
                  sendPhoto(odt, _image);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            backgroundColor: Colors.red,
            heroTag: UniqueKey(),
            label: Text("Camara"),
            icon: Icon(Icons.camera),
            onPressed: () {
              getImageFile(ImageSource.camera);
            },
          ),
          SizedBox(
            width: 5.0,
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.red,
            heroTag: UniqueKey(),
            label: Text("Galeria"),
            icon: Icon(Icons.photo_library),
            onPressed: () {
              getImageFile(ImageSource.gallery);
            },
          )
        ],
      ),
    );
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
                  "Foto",
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
    String pagina = '';

    switch(pageReturn){
      case 1:
        pagina = 'nuevas';
        break;
      case 2:
        pagina = 'abiertas';
        break;
      case 3:
        pagina = 'cerradas';
        break;
      default:
    }
    Navigator.of(context).pushReplacementNamed(pagina);
  }

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if(image != null){
      setState(() {
        _image = image;
        _ismageloaded = true;
      });
    }
  }

  sendPhoto(Odtmodel model, File imagen) async {
    if (imagen != null) {
      showCustomLoadingWidget(Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 1.0,),
            Text("Enviando...")
          ],
        )
      ));   
      int resultado = await bloc.sendPhoto(imagen, model.odt);
      if (resultado == 1) {
        hideLoadingDialog();
        final snackbar = SnackBar(
          content: Text("Envio completado"),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      }
    }
  }
}
