// ignore_for_file: file_names
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:sqlite/Control/ConexionDB.dart';
import 'package:sqlite/Modelo/Usuario.dart';
import 'package:flutter/material.dart';

class UsuarioDB extends ConexionDB {
  Future<int> crateItem(Usuario usuario) async {
    final Database db = await initializeDB();
    final id =  await db.insert('Usuarios', usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }


  find(String nombre) async {
    final Database db = await initializeDB();
    var res =
        await db.query("Usuarios", where: "nombre = ?", whereArgs: [nombre]);
    return res.isNotEmpty ? Usuario.fromMap(res.first) : null;
  }

  Future<void> delete(String nombre) async {
    final Database db = await initializeDB();
    try {
      await db.delete("Usuarios", where: "nombre = ?", whereArgs: [nombre]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<int> update(Usuario note) async {
    final Database db = await initializeDB();
    return db
        .update("Usuarios", note.toMap(), where: 'nombre = ?', whereArgs: [note.nombre]);
  }

}
