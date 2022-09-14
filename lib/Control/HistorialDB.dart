import 'package:sqflite/sqflite.dart';
import 'package:sqlite/Control/ConexionDB.dart';
import '../Modelo/Usuario.dart';

class HistorialDB extends ConexionDB{
  Future<List<Usuario>> getItems() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Historial');
    print(queryResult.map((e) => Usuario.fromMap(e)).toList().length);
    return queryResult.map((e) => Usuario.fromMap(e)).toList();
  }
}