import 'dart:io';
import 'dart:math';

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

  Future _leerTexto(FirebaseVisionImage miImagen) async{

    texto = [];
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

  Future _leerCodigoBarras(FirebaseVisionImage miImagen, List<Barcode> lista) async{
    texto = [];
    for(Barcode barcode in lista){
      var ll = barcode.rawValue.toString();
      print(ll);

    }
  }

  Future _detector() async {
    FirebaseVisionImage miImagen = FirebaseVisionImage.fromFile(imagenTomada);
    List<Barcode> codigoBarras = await FirebaseVision.instance.barcodeDetector().detectInImage(miImagen);
    if(codigoBarras.length > 0){
      _leerCodigoBarras(miImagen,codigoBarras);
    }else{
      _leerTexto(miImagen);
    }
  }


  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        _regresar(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Escanear", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 25.0,),
              isImageLoaded 
              ? Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                width: _width,
                height: _height * 0.4,
                alignment: Alignment.center,
                child: Image.file(imagenTomada),
              )
              : Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image.asset('assets/images/no-image.png'),
              ),
              RaisedButton(
                child: Text('Tomar Foto'),
                onPressed: _tomarImagen,
              ),
              RaisedButton(
                child: Text('Leer Texto'),
                onPressed: _detector,
              ),
              Expanded(
                child: texto.length == 0
                ? Container()
                : Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
      ),
    );
  }
  void _regresar(BuildContext context){
    Navigator.pop(context);
  }
}