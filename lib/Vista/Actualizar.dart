// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Control/UsuarioDB.dart';
import '../Modelo/Usuario.dart';
import 'MenuLateral.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class Actualizar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ActualizarState createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  final boxNombre = TextEditingController();
  final boxEdad = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  final boxBuscar = TextEditingController();
  final boxFecha = TextEditingController();
  String selectedValue = "Genero";
  bool boxBandera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actualizar'),
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
        genero(context),
        campoEdad(context),
        campoEstatura(),
        campoPeso(),
        btnActualizar(context),
      ],
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
                  Usuario nuevo = await UsuarioDB().find(boxBuscar.text);
                  boxNombre.text = nuevo.nombre.toString();
                  //selectedValue=nuevo.genero.toString();
                  boxFecha.text = nuevo.genero.toString();
                  boxEdad.text = nuevo.edad.toString();
                  boxPeso.text = nuevo.peso.toString();
                  boxEstatura.text = nuevo.estatura.toString();
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
            enabled: boxBandera,
            decoration: decoracionBox("Nombre")));
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    if (boxBandera) {
      List<DropdownMenuItem<String>> menuItems = [
        const DropdownMenuItem(value: "Genero", child: Text("Genero")),
        const DropdownMenuItem(value: "M", child: Text("M")),
        const DropdownMenuItem(value: "F", child: Text("F")),
      ];
      return menuItems;
    } else {
      List<DropdownMenuItem<String>> menuItems = [];
      return menuItems;
    }
  }

  Widget genero(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: DropdownButtonFormField(
          autofocus: boxBandera,
          items: dropdownItems,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          decoration: InputDecoration(
            enabled: boxBandera,
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
          enabled: boxBandera,
          controller: boxEdad, //editing controller of this TextField
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              DateTime date3 = DateTime.parse(formattedDate);
              final date2 = DateTime.now().difference(date3).inDays;
              int A = date2 ~/ 365;
              int M = date2 ~/ 30;
              if (A >= 2) {
                year = "$A Años";
              } else {
                year = "$M Meses";
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
            controller: boxEstatura,
            enabled: boxBandera,
            decoration: decoracionBox("Estatura")));
  }

  Widget campoPeso() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxPeso,
            enabled: boxBandera,
            decoration: decoracionBox("Peso")));
  }

  Widget btnActualizar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      width: 150,
      child: TextButton.icon(
        icon: const Icon(Icons.update),
        label: const Text("Actualizar"),
        style: TextButton.styleFrom(
          primary: Colors.black,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () async {
          Usuario nuevo = await UsuarioDB().find(boxBuscar.text);
          print(nuevo.edad);
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
