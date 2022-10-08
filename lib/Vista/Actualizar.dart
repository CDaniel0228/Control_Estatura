// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Control/UsuarioDB.dart';
import '../Control/Mensajes.dart';
import '../Modelo/Usuario.dart';
import 'Elementos.dart';
import 'MenuLateral.dart';

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
  bool band =false;

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
        Elementos().campoNombre(boxNombre, false),
        genero(context),
        campoEdad(context),
        Elementos().campoEstatura(boxEstatura, band),
        Elementos().campoPeso(boxPeso, band),
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
                  selectedValue=nuevo.genero.toString();
                  boxFecha.text = nuevo.genero.toString();
                  boxEdad.text = nuevo.edad.toString();
                  boxPeso.text = nuevo.peso.toString();
                  boxEstatura.text = nuevo.estatura.toString();
                  setState(() {
                    band=true;
                  });
                  }
                }
              },
              child: Text("Buscar"),
            )
          ],
        ));
  }




  Widget genero(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: DropdownButtonFormField(
          autofocus: band,
          items: Elementos().dropdownItems,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          decoration: InputDecoration(
            enabled: band,
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
          enabled: band,
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
          year=await Elementos().funcionFecha(context);
              setState(() {
                boxEdad.text = year; //set output date to TextField value.
              });
            
          },
        ));
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
          if(camposBacios()){
            UsuarioDB().update(Usuario(
              nombre: boxNombre.text,
              genero: selectedValue,
              edad: boxEdad.text,
              peso: double.parse(boxPeso.text),
              estatura: double.parse(boxEstatura.text)));
              limpiar();
              Mensajes().info("Actualizacion exitosa");
              setState(() {
                band=false;
              });
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
