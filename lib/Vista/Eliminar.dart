// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';

import 'MenuLateral.dart';

class Eliminar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EliminarState createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
  final boxNombre = TextEditingController();
  final boxEdad = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  final boxBuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eliminar'),
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
        campoEstatura(),
        campoPeso(),
        btnRegistrar(context)],
    ));
  }

  Widget campoBusqueda() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
            controller: boxBuscar, decoration: decoracion("Buscar por nombre")));
  }

  Widget campoNombre() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre,
            decoration: decoracionBox("Nombre")));
  }

  Widget campoEdad() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEdad,
            decoration: decoracionBox("Edad")));
  }

  Widget campoEstatura() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEstatura,
            decoration: decoracionBox("Estatura")));
  }

  Widget campoPeso() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxPeso,
            decoration: decoracionBox("Peso")));
  }

  Widget btnRegistrar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.delete_forever),
        label: const Text("Eliminar"),
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