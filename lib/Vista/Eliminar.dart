// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';

import '../Control/Mensajes.dart';
import '../Control/UsuarioDB.dart';
import '../Modelo/Usuario.dart';
import 'Elementos.dart';
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
  final boxGenero = TextEditingController();
    final boxFecha = TextEditingController();
  bool band =false;

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
        Elementos().campoNombre(boxNombre, band),
        genero(),
        campoEdad(),
        Elementos().campoEstatura(boxEstatura, band),
        Elementos().campoPeso(boxPeso, band),
        btnEliminar(context),],
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
                    decoration: Elementos().decoracionBuscar("Buscar por nombre"))),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                if (boxBuscar.text.isNotEmpty) {
                  
                  if(await UsuarioDB().find(boxBuscar.text)!=null){
                    Usuario nuevo = await UsuarioDB().find(boxBuscar.text);
                  boxNombre.text = nuevo.nombre.toString();
                  boxGenero.text=nuevo.genero.toString();
                  boxFecha.text = nuevo.genero.toString();
                  boxEdad.text = nuevo.edad.toString();
                  boxPeso.text = nuevo.peso.toString();
                  boxEstatura.text = nuevo.estatura.toString();
                  
                  }
                }
              },
              child: Text("Buscar"),
            )
          ],
        ));
  }


  Widget genero() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxGenero, enabled: band, decoration: Elementos().decoracionBox("Genero")));
  }

  Widget campoEdad() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEdad, enabled: band, decoration: Elementos().decoracionBox("Edad")));
  }

  Widget btnEliminar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.delete),
        label: const Text("Eliminar"),
        style: TextButton.styleFrom(
          primary: Colors.black,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () async {
          if(camposBacios()){
            if(UsuarioDB().delete(boxNombre.text)!=null){
              limpiar();
              Mensajes().info("Eliminacion exitosa");
            }
             
          }else{
            Mensajes().info("Campos bacios");
          }
        },
      ),
    );
  }

camposBacios() {
    return boxNombre.text.isNotEmpty ;
  }

  limpiar(){
    boxEdad.text='';
    boxNombre.text='';
    boxPeso.text='';
    boxEstatura.text='';
    boxGenero.text='';
  }
}