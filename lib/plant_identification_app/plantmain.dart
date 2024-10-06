import 'package:bpt_gamer/plant_identification_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(PlantIdentificationApp());
// }

class PlantIdentificationApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Identification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
