// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Vista/Elementos.dart';
import '../Control/Mensajes.dart';
import '../Control/UsuarioDB.dart';
import '../Modelo/Usuario.dart';
import 'MenuLateral.dart';

// ignore: use_key_in_widget_constructors
class Registrar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final boxNombre = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  final boxEdad = TextEditingController();
  String selectedValue = "Genero";
  bool band=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrar datos'),
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
        Elementos().campoNombre(boxNombre, band),
        genero(context),
        campoEdad(context),
        Elementos().campoEstatura(boxEstatura, band),
        Elementos().campoPeso(boxPeso, band),
        btnRegistrar(context)
      ],
    ));
  }

  Widget genero(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
      child: DropdownButtonFormField(
      items: Elementos().dropdownItems,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) => value == null ? "Select a country" : null,
      dropdownColor: Colors.white,
      value: selectedValue,
    ));
  }

  Widget campoEdad(BuildContext context) {
    String year;
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
    child: TextField(
      controller: boxEdad, //editing controller of this TextField
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        prefixIcon: Icon(Icons.calendar_today),
          labelText: "Edad" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        year=await Elementos().funcionFecha(context);
          setState(()  {
            boxEdad.text = year; 
          });
        
      },
    ));
  }

 Widget btnRegistrar(context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.add_box),
        label:  const Text("Registrar"),
        style: TextButton.styleFrom(
          primary: Colors.black,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () async {
          if(camposBacios()){
            UsuarioDB().crateItem(Usuario(
              nombre: boxNombre.text,
              genero: selectedValue,
              edad: boxEdad.text,
              peso: double.parse(boxPeso.text),
              estatura: double.parse(boxEstatura.text)));
              limpiar();
              Mensajes().info("Guardado exitoso");
          }else{
            Mensajes().info("Campos bacios");
          }
        
        },
      ),
    );
  }
  camposBacios() {
    return boxNombre.text.isNotEmpty & (selectedValue!="Genero")
    & boxPeso.text.isNotEmpty & boxEstatura.text.isNotEmpty &boxEdad.text.isNotEmpty ;
  }

  limpiar(){
    boxEdad.text='';
    boxNombre.text='';
    boxPeso.text='';
    boxEstatura.text='';
    setState(() {
          selectedValue = "Genero";
        });
  }

}
