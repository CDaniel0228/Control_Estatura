import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Elementos {  
   Widget campoNombre(boxNombre, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre, enabled: band, decoration: decoracionBox("Nombre")));
  }
  

  Widget campoEstatura(boxEstatura, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEstatura, enabled: band, decoration: decoracionBox("Estatura")));
  }

  Widget campoPeso(boxPeso, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child:
            TextField(controller: boxPeso, enabled:band ,decoration: decoracionBox("Peso")));
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Genero", child: Text("Genero")),
      const DropdownMenuItem(value: "M", child: Text("M")),
      const DropdownMenuItem(value: "F", child: Text("F")),
    ];
    return menuItems;
  }

  funcionFecha(context) async {
    String year;
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
         
        } else {
          year="Fecha no seleccionada";
        }
        return year;
  }

  decoracionBuscar(nombre) {
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