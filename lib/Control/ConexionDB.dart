// ignore_for_file: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexionDB {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'scd.db'),
      onCreate: (db, version) async {
        tablaUsuario(db);
        tablaHistorial(db);
        triggerInsertar(db);
        triggerActualizar(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          updateTable(db);
          tablaUsuario(db);
        }
      },
      onDowngrade: onDatabaseDowngradeDelete,
      readOnly: false,
      singleInstance: true,
      onConfigure: onConfigure,
      version: 1,
    );
  }

  Future onConfigure(Database bd) async {
    await bd.execute('PRAGMA foreign_keys = ON');
  }

  void updateTable(Database bd) {
    bd.execute('ALTER TABLE Company ADD description TEXT');
  }

  void tablaUsuario(Database bd) {
    bd.execute('DROP TABLE IF EXISTS Usuarios');
    bd.execute('''CREATE TABLE Usuarios(
            nombre	TEXT NOT NULL,
            genero	TEXT NOT NULL,
            edad	TEXT NOT NULL, 
            peso	REAL NOT NULL,
            estatura	REAL NOT NULL,
            PRIMARY KEY(nombre))''');
  }

  void tablaHistorial(Database bd) {
    bd.execute('DROP TABLE IF EXISTS Historial');
    bd.execute('''CREATE TABLE Historial(
            id	INTEGER,
            nombre	TEXT NOT NULL,
            genero	TEXT NOT NULL,
            edad	TEXT NOT NULL,
            peso	REAL NOT NULL,
            estatura	REAL NOT NULL,
            fecha	TEXT NOT NULL,
            FOREIGN KEY(nombre) REFERENCES Usuarios(nombre) ON DELETE CASCADE,
            PRIMARY KEY(id AUTOINCREMENT))''');
  }

  void triggerInsertar(Database bd) {
    bd.execute('DROP TRIGGER IF EXISTS historialI');
    bd.execute('''CREATE TRIGGER historialI
            AFTER UPDATE ON Usuarios
            FOR EACH ROW
            BEGIN
            INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha)
            VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW'));
            END''');
  }

  void triggerActualizar(Database bd) {
    bd.execute('DROP TRIGGER IF EXISTS historialA');
    bd.execute('''CREATE TRIGGER historialA
            AFTER INSERT ON Usuarios
            FOR EACH ROW
            BEGIN
            INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha)
            VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW'));
            END''');
  }
}
