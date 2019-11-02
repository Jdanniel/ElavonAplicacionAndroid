import 'dart:io';

import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TomarFoto extends StatefulWidget {
  @override
  _TomarFotoState createState() => _TomarFotoState();
}

class _TomarFotoState extends State<TomarFoto> {
  
  File _image;
  bool _ismageloaded = false;
  bool _enviadoPhoto = false;
  OdtsBloc bloc;
  Odtmodel odt = new Odtmodel();

  @override
  Widget build(BuildContext context) {
    final Odtmodel odtData = ModalRoute.of(context).settings.arguments;
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
              Center(
                child: Container(
                  height: 250.0,
                  width: 250.0,
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child:
                            _ismageloaded ? Image.file(_image) : Text("Imagen")),
                  ),
                ),
              ),
              _enviadoPhoto ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Enviando"),
                    CircularProgressIndicator()
                  ],
                ),
              ) : IconButton(
                onPressed: () {sendPhoto(odt, _image);},
                icon: Icon(Icons.send),
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
        padding: EdgeInsets.only(left: 10.0),
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
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

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
      _ismageloaded = true;
    });
  }

  sendPhoto(Odtmodel model, File imagen) async {
    if(imagen != null){
      _enviadoPhoto = true;
      bloc.sendPhoto(imagen, model.odt);
      _enviadoPhoto = false;
    }
  }
}
