import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditImage extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  final _formkey = GlobalKey<FormState>();
  File _image;
  TextEditingController _controller;
  List<String> texto = new List<String>();

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    //Cropping Image

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 2.0, ratioY: 2.0),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio7x5,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      _image = croppedFile;
      print(_image.lengthSync());
    });

    FirebaseVisionImage miImagen = FirebaseVisionImage.fromFile(_image);
    TextRecognizer reconocerTexto = FirebaseVision.instance.textRecognizer();
    VisionText leerTexto = await reconocerTexto.processImage(miImagen);

    for (TextBlock block in leerTexto.blocks) {
      for (TextLine line in block.lines) {
        print("Line: ${line.text}");
        setState(() {
          _controller = new TextEditingController(text: line.text.trim());
        });
        /*
        for(TextElement word in line.elements){
          print("Word: ${word.text}");
          setState(() {
            texto.add(word.text);
          });
        }
        */
      }
    }
    reconocerTexto.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                child: _image == null
                    ? Image.asset(
                        'assets/images/no-image.png',
                        height: 250.0,
                        width: 250.0,
                      )
                    : Image.file(
                        _image,
                        height: 250,
                        width: 250,
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.5, right: 30.5),
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                          ),
                          controller: _controller,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            backgroundColor: Colors.pinkAccent,
            label: Text("Camara"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(
            width: 20.0,
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.pinkAccent,
            label: Text("Galeria"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          )
        ],
      ),
    );
  }
}
