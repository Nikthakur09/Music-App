import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/modules/home/pages/home.dart';
import '../../../shared/config.dart';
import '../../Singers/page/singer_view.dart';

// import 'package:music_app_final/modules/singer/models/singer.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _moveToNextScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  _loadAndMove() {
    Timer(Duration(seconds: 4), () {
      _moveToNextScreen();
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAndMove();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: media.width,
              height: media.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Amazon Music',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
