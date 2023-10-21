import 'dart:async';
import 'dart:io';

import 'package:login/models/carrera_model.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AgendaDB{

  static final nameDB = 'AGENDADB';
  static final versionDB = 1;

  static Database? _database;
  
  Future<Database?> get database async{
    if(_database != null) return _database;
    return _database = await _initDatabase();
  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    ); 
  }

  FutureOr<void> _createTables(Database db, int version) {
    //las ''' es la forma de indicar un query
    String query = '''
    CREATE TABLE tblTareas(
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE,
      fecExpiracion DateTime,
      fecRecordatorio DateTime,
      idProfe INTEGER,
      FOREING KEY (idProfe) REFERENCES tblProfesor(idProfe)
      );
      ''';

    String queryP = '''
    CREATE TABLE tblProfesor(
      idProfe INTEGER PRIMARY KEY,
      nomProfe VARCHAR(50),
      email VARCHAR(50),
      idCarrera INTEGER,
      FOREING KEY (idCarrera) REFERENCES tblCarrera(idCarrera)
    );
     ''';

    String queryC = '''
    CREATE TABLE tblCarrera(
      idCarrera INTEGER PRIMARY KEY,
      nomCarrera VARCHAR(50)
    );
    ''';

      db.execute(queryC);
      db.execute(queryP);
      db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String,dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }


  Future<int> UPDATE(
    String tName, String field, Map<String, dynamic> data) async {
      var connection = await database;
      return connection!.update(tName, data, where: '$field = ?', whereArgs: [data[field]]);
  }

  Future<int> DELETE(String tblName, String field, int objectId, String? childTable) async {
    /*var conexion = await database;
    return conexion!.delete(tblName, 
      where: 'idTask = ?',
      whereArgs: [idTask]
    );*/
     var connection = await database;
    if (childTable != null) {
      final dependentRows = await connection!
          .rawQuery("select * from $childTable where $field = $objectId");
      if (dependentRows.isEmpty) {
        return connection
            .delete(tblName, where: '$field = ?', whereArgs: [objectId]);
      } else {
        return 0;
      }
    } else {
      return connection!
          .delete(tblName, where: '$field = ?', whereArgs: [objectId]);
    }
  }
  
  Future<List<TaskModel>> GETALLTASK() async{
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<ProfesorModel>> GETALLPROFE() async{
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((profe) => ProfesorModel.fromMap(profe)).toList();
  }

  Future<List<CarreraModel>> GETALLCARRERA  () async{
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((carrera) => CarreraModel.fromMap(carrera)).toList();
  }

  Future<CarreraModel> GETCAREER(int objectId) async {
    var connection = await database;
    var result = await connection!
        .query('tblCarrera', where: 'idCarrera = ?', whereArgs: [objectId]);
    return result.map((career) => CarreraModel.fromMap(career)).toList().first;
  }

  Future<ProfesorModel> GETTEACHER(int objectId) async {
    var connection = await database;
    var result = await connection!
        .query('tblProfesor', where: 'idProfesor = ?', whereArgs: [objectId]);
    return result
        .map((teacher) => ProfesorModel.fromMap(teacher))
        .toList()
        .first;
  }

  Future<void> DELETEALL(table) async {
    var connection = await database;
    await connection!.delete(table, where: '1=1');
  }

  Future<List<CarreraModel>> GETFILTEREDCAREERS(String input) async {
    var connection = await database;
    var sql = "select * from tblCarrera where nomCarrera like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((career) => CarreraModel.fromMap(career)).toList();
  }

  Future<List<ProfesorModel>> GETFILTEREDTEACHERS(String input) async {
    var connection = await database;
    var sql = "select * from tblProfesor where nomProfe like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((teacher) => ProfesorModel.fromMap(teacher)).toList();
  }

  Future<List<TaskModel>> GETFILTEREDTASKS(String input, int? input2) async {
    var connection = await database;
    var sql = input2 != null
        ? "select * from tblTareas where nameTask like '%$input%' and sttTask = $input2"
        : "select * from tblTareas where nameTask like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> GETUNFINISHEDTASKS() async {
    var connection = await database;
    var sql = "select * from tblTareas where sttTask = 0";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

}