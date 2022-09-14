// ignore_for_file: file_names
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Control/UsuarioDB.dart';
import 'package:sqlite/Control/Mensajes.dart';
import 'package:sqlite/Modelo/Usuario.dart';
import 'MenuLateral.dart';

// ignore: use_key_in_widget_constructors
class Registrar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final boxNombre = TextEditingController();
  final boxEdad = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  String selectedValue = "Genero";
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
        campoNombre(),
        genero(context),
        campoEdad(context),
        campoEstatura(),
        campoPeso(),
        btnRegistrar(context)
      ],
    ));
  }

  Widget campoNombre() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre, decoration: decoracionBox("Nombre")));
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Genero", child: Text("Genero")),
      const DropdownMenuItem(value: "M", child: Text("M")),
      const DropdownMenuItem(value: "F", child: Text("F")),
    ];
    return menuItems;
  }

  Widget genero(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
      child: DropdownButtonFormField(
      items: dropdownItems,
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
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          DateTime date3=DateTime.parse(formattedDate);
          final date2=DateTime.now().difference(date3).inDays;
          int A=date2~/365;
          int M=date2~/30;
          if(A>=2){
            year="$A Años";
          }else{
            year="$M Meses";
          }
         
          setState(() {
            boxEdad.text = year; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    ));
  }

  Widget campoEstatura() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEstatura, decoration: decoracionBox("Estatura")));
  }

  Widget campoPeso() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child:
            TextField(controller: boxPeso, decoration: decoracionBox("Peso")));
  }

  Widget btnRegistrar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.add_box),
        label: const Text("Registrar"),
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
    return boxNombre.text.isNotEmpty & boxEdad.text.isNotEmpty 
    & boxPeso.text.isNotEmpty & boxEstatura.text.isNotEmpty & selectedValue.isNotEmpty;
  }

  limpiar(){
    boxNombre.text='';
    boxEdad.text='';
    boxPeso.text='';
    boxEstatura.text='';
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
}
