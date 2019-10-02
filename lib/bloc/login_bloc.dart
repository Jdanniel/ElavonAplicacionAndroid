import 'package:elavonappmovil/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get usernameStream => _usernameController.stream.transform(validarUsername);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
    Observable.combineLatest2(usernameStream, passwordStream, (a,b) => true);

  //Insertar valores al Stream
  Function(String) get changeUserName => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get gusername => _usernameController.value;
  String get gpassword => _passwordController.value;

  //cerrar Stream
  dispose(){
    _usernameController?.close();
    _passwordController?.close();
  }

}