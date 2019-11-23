import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifiations(int idusuario) {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.subscribeToTopic(idusuario.toString());

    _firebaseMessaging.getToken().then((token) {
      print('================ FCM Token ================');
      print(token);
      // dpeiJYBsQ3Y:APA91bGhfcigbdXzf5BZ1WTYJABAdLn4Y28oR7q0lGjW1thGp75UVqJzpe2pNQ7Po_bLVhkyVpN54mQKfibminxeM7u5jMRdKS1z45dubQc4QnicaOy5V8khrg6pYM7Ry4ir22NnfPPB
    });

    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocationsPlugin.initialize(initializationSettings, onSelectNotification: _onselectNotification);

    _firebaseMessaging.configure(onMessage: (info) async {
      print('===== On Message =====');
      print(info);
      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['Comida'] ?? 'no-data';
      }
      await displayNotification(info);
      _mensajesStreamController.sink.add(argumento);
    }, onLaunch: (info) async {
      print('==== On Launch ====');
      print(info);
      final noti = info['data']['Comida'];
      print(noti);
    }, onResume: (info) async {
      print('=== On Resume ===');
      print(info);
      final noti = info['data']['Comida'];
      print(noti);
    });
  }

  Future _onselectNotification(String payload) async{
    if(payload != null){
      debugPrint('notification payload: ' +payload);
    }
  }

  Future displayNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelId', 'flutterfcm', 'Notificaciones de actualizacion',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocationsPlugin.show(0, 
        message['notification']['title'],
        message['notification']['body'], 
        platformChannelSpecifics,
        payload: 'Hola');
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
