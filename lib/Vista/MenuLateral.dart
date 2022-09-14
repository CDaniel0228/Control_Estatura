// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite/Constantes.dart';

// ignore: use_key_in_widget_constructors
class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF454d5a),
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("SCD"),
            accountEmail: Text("SCD@gmail.com"),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/login.png')),
                color: headerColor),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registrar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'actualizar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    Text(
                      "Actualizar",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'eliminar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_sweep,
                      color: Colors.white,
                    ),
                    Text(
                      "Eliminar",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: TextButton(
                onPressed: () async {
                  //if (await Autentificacion().signedOut()) {
                  Navigator.pushNamed(context, 'historial');
                  // }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.history_toggle_off_sharp,
                      color: Colors.white,
                    ),
                    Text(
                      "Historial",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: TextButton(
                onPressed: () => exit(0),
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    Text(
                      "Salir",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}