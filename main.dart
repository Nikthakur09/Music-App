import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/modules/Intro/Pages/splash_screen.dart';



Future main() async {
  await dotenv.load(fileName: ".env"); // Env will be loaded on RAM
  runApp( MaterialApp (
    color: Colors.black,
    debugShowCheckedModeBanner: false ,
    home: SplashScreen(),
  ),
  );
}
 