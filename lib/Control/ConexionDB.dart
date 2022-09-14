// ignore_for_file: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexionDB{
   Future<Database> initializeDB() async {
    final path=await getDatabasesPath();
    return openDatabase(
      join(path, 'scd.db'),
      onCreate: (database, version) async {
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        await database.execute("CREATE TABLE Usuarios (" +
            "nombre	TEXT NOT NULL," +
            "genero	TEXT NOT NULL," +
            "edad	TEXT NOT NULL," +
            "peso	REAL NOT NULL," +
            "estatura	REAL NOT NULL," +
            "PRIMARY KEY(nombre))");
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        await database.execute("CREATE TABLE Historial (" +
            "id	INTEGER," +
            "nombre	TEXT NOT NULL," +
            "genero	TEXT NOT NULL," +
            "edad	TEXT NOT NULL," +
            "peso	REAL NOT NULL," +
            "estatura	REAL NOT NULL," +
            "fecha	TEXT NOT NULL," +
            "FOREIGN KEY(nombre) REFERENCES Usuarios(nombre) ON DELETE CASCADE ON UPDATE CASCADE," +
            "PRIMARY KEY(id AUTOINCREMENT))");
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        await database.execute("CREATE TRIGGER historialA " +
            "AFTER UPDATE ON Usuarios " +
            "FOR EACH ROW " +
            "BEGIN " +
            "INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha) " +
            "VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW')); " +
            "END");
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        await database.execute("CREATE TRIGGER historialI " +
            "AFTER INSERT ON Usuarios " +
            "FOR EACH ROW " +
            "BEGIN " +
            "INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha) " +
            "VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW')); " +
            "END");
      },
      version: 1,
    );
  }

}