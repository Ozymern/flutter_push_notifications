import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageStreamController.stream;

  //metodo para cerrar el stream
  dispose() {
    _messageStreamController.close();
  }

  initNotifications() async {
    //pedir permiso al usuario
    _firebaseMessaging.requestNotificationPermissions();
    //obtener el token del dispositivo
    final String token = await _firebaseMessaging.getToken();
//e_HaA7WvMVA:APA91bHXk7DKTFY4ZD5L6lBxXKe2lmfaDEq8Brm0nwH25PHdX9K0hkL4eA04K8b2k8aCpqeGwMUJWZw9i-ua6PiSWGDfwqXaqw09yRndXP-R81BlR_p0D7nIQfWpgBDoRrh7pJ17NF2y
    print(token);
    String arguments = 'no-data';
    //diferentes escenarios de una notificacion
    _firebaseMessaging.configure(
        //onMessage se va a disparar cuando la aplicacion este abierta
        onMessage: (info) {
      print('========== onMessage $info');
      //capturar valor de un campo de la data
//      final not = info['data']['juego'];
//determinar que plataforma es (ios o android)

      if (Platform.isAndroid) {
        arguments = info['data']['juego'] ?? 'no-data';
      }
      _messageStreamController.sink.add(arguments);
    }, onLaunch: (info) {
      print('========== onLaunch $info');
    }, onResume: (info) {
      print('========== onResume $info');
      _messageStreamController.sink.add(arguments);
    });
  }
}
