// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';
import 'package:sqlite/Control/HistorialDB.dart';
import 'package:sqlite/Vista/Analisis.dart';

import '../Control/UsuarioDB.dart';
import '../Modelo/Usuario.dart';
import 'MenuLateral.dart';

class Historial extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  final boxBuscar = TextEditingController();
  List<Usuario> listaA = [];
  List<Usuario> listaB=[];
  List<List<Usuario>> listaC=[];

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
        _myListView(context),
      ],
    ));
  }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listaA.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            if (index == 0) {}
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Analisis(listaA),
              ),
            );
          },
          leading: const Icon(Icons.list),
          trailing: const Text(
            "Analizar",
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          title: Text(listaA[index].edad.toString()),
        );
      },
    );
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
                  if (await HistorialDB().getItems(boxBuscar.text) != null) {
                    List<Usuario> lista =
                        await HistorialDB().getItems(boxBuscar.text);
                      
                    for (int i = 0; i < lista.length; i++) {
                      List<String> splitted =
                          lista.elementAt(i).edad.toString().split(' ');
                      int num = int.parse(splitted.elementAt(0));
                      if (num < 3 & splitted.elementAt(1).compareTo("Meses")) {
                        listaB.add(lista.elementAt(i));
                        
                      }

                    }
                    for (int i = 0; i < lista.length; i++) {
                      for (int j = 0; j < lista.length; j++) {
                      List<String> splitted =
                          lista.elementAt(j).edad.toString().split(' ');
                      int num = int.parse(splitted.elementAt(0));
                      if (num < 3 & splitted.elementAt(1).compareTo("Meses")) {
                        listaB.add(lista.elementAt(i));
                        
                      }

                      }
                        listaC.add(listaB);
                        
                    }

                    for (int i = 0; i < lista.length; i++) {
                      List<String> splitted =
                          lista.elementAt(i).edad.toString().split(' ');
                      int num = int.parse(splitted.elementAt(0));
                      if (num < 3 & splitted.elementAt(1).compareTo("Meses")) {
                        listaB.add(lista.elementAt(i)); 
                      }    
                    }
                    listaC.add(listaB);
                    listaB.clear();
                    
                    setState(() {
                      listaA = lista;
                    });
                  }
                }
              },
              child: Text("Buscar"),
            )
          ],
        ));
  }

  decoracion(nombre) {
    return InputDecoration(
        labelText: nombre,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ));
  }

  listaMeses(lista) {
    for (int i = 0; i < lista.length; i++) {
      List<String> splitted = lista.elementAt(i).edad.toString().split(' ');
      int num = int.parse(splitted.elementAt(0));
      if (num <= 3 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 3 || num <= 6 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 6 || num <= 9 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 9 || num <= 12 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 12 || num <= 15 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 15 || num <= 18 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }else if (num > 18 & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }
    }
  }

  ciclo(lista, n){
    for (int i = 0; i < lista.length; i++) {
      List<String> splitted = lista.elementAt(i).edad.toString().split(' ');
      int num = int.parse(splitted.elementAt(0));
      if (num <= n & splitted.elementAt(1).compareTo("Meses")) {
        listaB.add(lista.elementAt(i));
      }
    }
    listaC.add(listaB);
  }
}
