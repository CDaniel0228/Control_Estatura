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
            padding: const EdgeInsets.only(top: kPadiinMenuT),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registrar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: kColorMenuLabel,
                    ),
                    Text(
                      "Registrar",
                      style: TextStyle(color: kColorMenuLabel, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: const EdgeInsets.only(top: kPadiinMenuT),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'actualizar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.update,
                      color: kColorMenuLabel,
                    ),
                    Text(
                      "Actualizar",
                      style: TextStyle(color: kColorMenuLabel, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: const EdgeInsets.only(top: kPadiinMenuT),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'eliminar');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_sweep,
                      color: kColorMenuLabel,
                    ),
                    Text(
                      "Eliminar",
                      style: TextStyle(color: kColorMenuLabel, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: const EdgeInsets.only(top: kPadiinMenuT),
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
                      color: kColorMenuLabel,
                    ),
                    Text(
                      "Historial",
                      style: TextStyle(color: kColorMenuLabel, fontSize: 25),
                    )
                  ],
                )),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: TextButton(
                onPressed: () => exit(0),
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: kColorMenuLabel,
                    ),
                    Text(
                      "Salir",
                      style: TextStyle(color: kColorMenuLabel, fontSize: 25),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}