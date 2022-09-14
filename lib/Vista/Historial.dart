// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';

import '../Control/UsuarioDB.dart';
import '../Modelo/Usuario.dart';
import 'MenuLateral.dart';

class Historial extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  final boxNombre = TextEditingController();
  final boxEdad = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  final boxBuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial'),
          centerTitle: true,
          backgroundColor: headerColor,
        ),
        drawer: MenuLateral(),
        body: SingleChildScrollView(child: panel(context)));
  }

  Widget panel(BuildContext context) {
    return Container(
        child: Column(
      children: [
        campoBusqueda(),
        campoNombre(),
        campoEdad(),
        btnRegistrar(context)],
    ));
  }

   Widget campoBusqueda() {
    return Container(
        //flatbutton
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          children: [
            Flexible(
                child: TextField(
                    controller: boxBuscar,
                    decoration: decoracion("Buscar por nombre"))),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                if (boxBuscar.text.isNotEmpty) {
                  Usuario nuevo = await UsuarioDB().find2(boxBuscar.text);
                  print(nuevo.peso.toString());
                }
              },
              child: Text("Buscar"),
            )
          ],
        ));
  }

  Widget campoNombre() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre,
            decoration: decoracionBox("Resultado")));
  }

  Widget campoEdad() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEdad,
            decoration: decoracionBox("Observaciones")));
  }

  

  Widget btnRegistrar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.analytics),
        label: const Text("Analisis"),
        style: TextButton.styleFrom(
          primary: Colors.black,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () async {
          
        },
      ),
    );
  }

  decoracionBox(nombre) {
    return InputDecoration(
        labelText: nombre,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ));
  }

  decoracion(nombre) {
    return InputDecoration(
        labelText: nombre,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}