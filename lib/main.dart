import 'package:flutter/material.dart';
import 'package:sqlite/Vista/Actualizar.dart';
import 'package:sqlite/Vista/Eliminar.dart';
import 'package:sqlite/Vista/Historial.dart';
import 'package:sqlite/Vista/Registrar.dart';
import 'Bienvenida.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Bienvenida().animacion(),
        'registrar': (context) => Registrar(),
        'actualizar': (context) => Actualizar(),
        'eliminar': (context) => Eliminar(),
        'historial': (context) => Historial(),
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        // ignore: avoid_print
        print('Ruta llamado ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext builder) => Bienvenida().animacion());
      },
    );
  }
}
