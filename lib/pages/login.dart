import 'package:date_format/date_format.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/provider/usuario_provider.dart';
import 'package:elavonappmovil/shapes/dibujarCurva0.dart';
import 'package:elavonappmovil/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usuarioProvider = new UsuarioProvider();
  bool _obscureText = true;
  bool _initProgressBar = false;  

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearForm(context,bloc),
        ],
      ),
    );
  }

  Widget _crearForm(BuildContext context, LoginBloc bloc){

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 125.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 3.0,
                  spreadRadius: 3.0,
                  offset: Offset(0.0,0.5)
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Bienvenido', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 30.0,),
                _crearTextFormFieldUsuario(bloc),
                SizedBox(height: 30.0,),
                _crearTextFormFieldPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBotonSubmit(bloc,context)
              ],
            ),
          ),
          _crearRecuperarPassword()
        ],
      ),
    );
  }

  Widget _crearBotonSubmit(LoginBloc bloc, BuildContext context){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(_initProgressBar){
          return Column(
            children: <Widget>[
              Text('Comprobando Datos...'),
              CircularProgressIndicator()
            ],
          );
        }else{
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0.0,
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          );
        }
      }
    );
  }

  Widget _crearRecuperarPassword(){
    return FlatButton(
      child: Text('Olvide mi contraseña', style: TextStyle(color: Colors.black, fontSize: 18.0),),
      onPressed: (){},
    );
  }

  Widget _crearTextFormFieldUsuario(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.usernameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            onChanged: (v)=> setState((){bloc.changeUserName(v);}),
            decoration: InputDecoration(
              labelText: 'Nombre de Usuario',
              fillColor: Colors.white,
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              )
            ),
          ),

        );
      }
    );

  }

  Widget _crearTextFormFieldPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  errorText: snapshot.error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: (){
                      setState(() {
                       _obscureText = !_obscureText; 
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,  
                onChanged: (v) => setState((){bloc.changePassword(v);}),              
              )
            ],
          ),

        );
      }
    );

  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final ola0 = Container(
      child: CustomPaint(
        painter: DibujarCurva0(),
      ),
    );

    final fondoAzul = Container(
      height: height,
      width: width,
      color: Color.fromRGBO(54,146,255,1.0),
      child: ola0,
    );


    return Stack(
      children: <Widget>[
        fondoAzul,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Image(
                    image: AssetImage('assets/images/Elavon_Icon.png'),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    
    setState(() {
      _initProgressBar = true;
    });

    Map info = await usuarioProvider.login(bloc.gusername, bloc.gpassword);
    
    if(info['res']){

    final _prefs = new PreferenciasUsuario();
    final fechaActual = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
    final updatesBloc = Provider.updatesBloc(context);
    final fechaMovil = await updatesBloc.selectUpdate();
      fechaActual != (fechaMovil != null ? fechaMovil.fecha : '') 
      ? Navigator.pushReplacementNamed(context, 'cargaCatalogos') 
      : Navigator.pushReplacementNamed(context, 'home');
    }else{   
      mostraAlerta(context, info['msg']);
    }    
    setState(() {
      _initProgressBar = false;
    });   
  }

}
