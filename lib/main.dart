import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/src/pages/home_page.dart';
import 'package:flutter_push_notifications/src/pages/message_page.dart';
import 'package:flutter_push_notifications/src/provider/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    final PushNotificationsProvider _pushProvider =
        new PushNotificationsProvider();
    _pushProvider.initNotifications();
    //escuchar los cambios que emiten los stream
    _pushProvider.messageStream.listen((data) {
      //  Navigator.pushNamed(context, 'message');
      navigatorKey.currentState.pushNamed('message', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //navigatorKey permite manejar estado del Navigator en toda esta clase
      navigatorKey: navigatorKey,
      title: 'Flutter Push  notificashion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'message': (BuildContext context) => MessagePage()
      },
    );
  }
}
