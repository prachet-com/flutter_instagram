import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/config/custom_router.dart';
import 'package:flutter_instagram/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          textTheme: const TextTheme(
            headline6: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),

      routes: CustomRouter.getRoutes(),
      initialRoute: SplashScreen.routeName,
    );
  }
}
