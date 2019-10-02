import 'dart:async';

class Validators{

  final validarUsername = StreamTransformer<String, String>.fromHandlers(
    handleData: (user,sink){
      if(user.length > 0){
        sink.add(user);
      }else{
        sink.addError('Ingresar mas de un caracter en el usuario');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Ingresar mas de 6 caracteres');
      }
    }
  );

}