import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/pages/menu/detalles/agregarcomentarios.dart';
import 'package:elavonappmovil/pages/menu/detalles/detalleInit.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elavonappmovil/pages/menu/detalles/tomarfoto.dart';

class DetalleOdtPage extends StatefulWidget {
  @override
  _DetalleOdtPageState createState() => _DetalleOdtPageState();
}

class _DetalleOdtPageState extends State<DetalleOdtPage> {
  final TomarFoto _tomarFoto = new TomarFoto();
  final DetalleInit _init = new DetalleInit();
  final AgregarComentario _comentario = new AgregarComentario();

  OdtsBloc odtBloc;
  Odtmodel odt = new Odtmodel();
  Widget _showPage = new DetalleInit();

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {

    odtBloc = Provider.odtsBloc(context);
    odt = odtBloc.getNuevoOdt;
    
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: _showPage,
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          items: <Widget>[
            Icon(
              Icons.list,
              size: 30,
            ),
            /*
            Icon(
              Icons.location_searching,
              size: 30,
            ),
            Icon(
              Icons.compare_arrows,
              size: 30,
            ),
            Icon(
              Icons.build,
              size: 30,
            ),
            */
            odt.idStatusAr != 6 && odt.idStatusAr != 7 && odt.idStatusAr != 8
                ? Icon(
                    Icons.add_a_photo,
                    size: 30,
                  )
                : Container(),
            odt.idStatusAr != 6 && odt.idStatusAr != 7 && odt.idStatusAr != 8
                ? Icon(
                    Icons.edit,
                    size: 30,
                  )
                : Container()
          ],
          onTap: (index) {
            setState(() {
              _showPage = _pageChooser(index);
            });
          },
        ));
  }

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _init;
        break;
      case 1:
        return _tomarFoto;
        break;
      case 2:
        return _comentario;
        break;
      default:
        return Container(
          child: Center(
            child: Text("No se encontro la pagina",
                style: TextStyle(fontSize: 30.0)),
          ),
        );
    }
  }
}
