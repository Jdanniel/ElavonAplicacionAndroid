import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  File imagenTomada;
  bool isImageLoaded = false;
  List<String> texto = new List<String>();

  Future _tomarImagen() async{
    var temp = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imagenTomada = temp;
      isImageLoaded = true;
    });
  }

  Future _leerTexto() async{

    texto = [];
    FirebaseVisionImage miImagen = FirebaseVisionImage.fromFile(imagenTomada);
    TextRecognizer reconocerTexto = FirebaseVision.instance.textRecognizer();
    VisionText leerTexto = await reconocerTexto.processImage(miImagen);

    for(TextBlock block in leerTexto.blocks){
      for(TextLine line in block.lines){
        for(TextElement word in line.elements){
          setState(() {
            texto.add(word.text);
          });
        }
      }
    }
    reconocerTexto.close();
  }


  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isImageLoaded 
            ? Container(
              width: _width,
              height: _height * 0.4,
              alignment: Alignment.center,
              child: Image.file(imagenTomada),
            )
            : Container(
              child: Image.asset('assets/images/no-image.png'),
            ),
            RaisedButton(
              child: Text('Tomar Foto'),
              onPressed: _tomarImagen,
            ),
            RaisedButton(
              child: Text('Leer Texto'),
              onPressed: _leerTexto,
            ),
            Expanded(
              child: texto.length == 0
              ? Container()
              : Container(
                child: ListView.builder(
                  itemCount: texto.length,
                  itemBuilder: (BuildContext ctxt, int index){
                    return new Text(texto[index]);
                  },
                ),
              ),
            ) 
          ],
        ),
    );
  }
}