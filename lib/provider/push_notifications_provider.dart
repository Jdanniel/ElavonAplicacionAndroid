import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifiations(){

    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token){

      print('================ FCM Token ================');
      print(token);
      // dpeiJYBsQ3Y:APA91bGhfcigbdXzf5BZ1WTYJABAdLn4Y28oR7q0lGjW1thGp75UVqJzpe2pNQ7Po_bLVhkyVpN54mQKfibminxeM7u5jMRdKS1z45dubQc4QnicaOy5V8khrg6pYM7Ry4ir22NnfPPB

    });

    _firebaseMessaging.configure(
      onMessage: (info) async {
        print('===== On Message =====');
        print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['Comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (info) async{
        print('==== On Launch ====');
        print(info);
        final noti = info['data']['Comida'];
        print(noti);
      },
      onResume: (info) async{
        print('=== On Resume ===');
        print(info);
        final noti = info['data']['Comida'];
        print(noti);
      }
    );

  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message){
    if(message.containsKey('data')){
      final dynamic data = message['data'];
      print(data);
    }
  }

  dispose(){
    _mensajesStreamController?.close();
  }

}