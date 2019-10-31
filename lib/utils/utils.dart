import 'package:flutter/material.dart';

void mostraAlerta(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Datos Incorrectos'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

void mostrarAlertDatosActualizado(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Actualizacion'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}