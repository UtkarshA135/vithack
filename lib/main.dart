
import 'package:certificate_generator/cert/cert/cert.dart';
import 'package:certificate_generator/cert/cert/cert3.dart';
import 'package:certificate_generator/cert/cert/cert4.dart';
import 'package:certificate_generator/cert/cert/details.dart';
import 'package:certificate_generator/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';
import 'cert/cert/cert2.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:certificate_generator/providers/home.dart';

import 'package:certificate_generator/screens/home.dart';
import 'package:certificate_generator/screens/result.dart';
import 'package:certificate_generator/screens/viewer.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
  await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
}

class MyApp extends StatelessWidget {
   final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Wiredash(
       navigatorKey: _navigatorKey,
      projectId: "demo_show_app-rxf5lpp",
      secret: "p6ju8f33970ly93ipzhwvcnqxsia03bw",
     // translation: MyTranslation(),
      theme: WiredashThemeData(
        primaryColor: Colors.purple,
        secondaryColor: Colors.purpleAccent,
        dividerColor: Colors.black,
        primaryBackgroundColor: Colors.purple[100],
      ),child:
    MaterialApp(
        navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Certificate Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    
          routes: {
        '/': (context) => SplashScreen(),
        '/cert': (context) => Cert(),
        '/viewer': (context) => ViewerScreen(),
        '/cert1':(context) => Cert2(),
        '/cert2':(context) => Cert3(),
        '/cert3':(context) => Cert4(),
      },
        initialRoute: '/',
      )  );
  }
}
