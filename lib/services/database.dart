import 'package:recipe_app/services/receta.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  return openDatabase(
    join(await getDatabasesPath(), 'recetas.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE recetas(nombre TEXT, ingredientes TEXT, procedimiento TEXT)");
    },
    version: 1,
  );
}

Future<List<Receta>> getDataFromDatabase() async {
  //Abro la base
  final Future<Database> database = openDB();
  //Creo una instancia
  final Database db = await database;
  //Realizo consulta
  final List<Map<String, dynamic>> maps = await db.query('recetas');

  List<Receta> res = List.generate(maps.length, (i) {
    return Receta(
        nombre: maps[i]['nombre'],
        ingredientes: maps[i]['ingredientes'],
        procedimiento: maps[i]['procedimiento']);
  });

  db.close();
  return res;
}

Future<void> deleteElement(String nombre) async {
  //Abro la base
  final Future<Database> database = openDB();
  //Creo una instancia
  final Database db = await database;
  db.delete('recetas', where: "nombre = ?", whereArgs: [nombre]);
  db.close();
}

Future<void> insertElement(Receta receta) async {
  //Abro la base
  final Future<Database> database = openDB();
  //Creo una instancia
  final Database db = await database;
  await db.insert(
      'recetas',
      {
        'nombre': receta.nombre,
        'ingredientes': receta.ingredientes,
        'procedimiento': receta.procedimiento
      },
      conflictAlgorithm: ConflictAlgorithm.ignore);
}

Future<void> updateElement(Receta nuevaReceta, String oldName) async {
  //Abro la base
  final Future<Database> database = openDB();
  //Creo una instancia
  final Database db = await database;
  await db.update(
      'recetas',
      {
        'nombre': nuevaReceta.nombre,
        'ingredientes': nuevaReceta.ingredientes,
        'procedimiento': nuevaReceta.procedimiento
      },
      where: "nombre = ?",
      whereArgs: [oldName]);

  db.close();
}
