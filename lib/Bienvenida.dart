// ignore: file_names
import 'package:animated_splash_screen/animated_splash_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Vista/Registrar.dart';

class Bienvenida {
  Widget animacion() {
    return AnimatedSplashScreen(
        splashIconSize: 350,
        duration: 1000,
        splash: 'asset/bienvenida.jpg',
        nextScreen: Registrar(),
        //splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: backTextColor);
  }
}