import 'package:sqlite3/sqlite3.dart';
import "config.dart" as config;

dynamic setup_database()
{
  if (config.connection == "sqlite")
  {
    return sqlite3.open(config.database);
  } else {
    throw Exception("This database hasn't been configured in this framework");
  }
}

enum DataType 
{
  INTEGER,
  VARCHAR,

}
extension DataTypeExtension on DataType 
{

  String get key 
  {
    switch (this) 
    {
      case DataType.INTEGER:
        return "int";
      
      case DataType.VARCHAR:
        return "varchar";

      default:
        return "null";

    }
  }

}

class Column
{
  String name = "";
  DataType type = DataType.INTEGER;
  int size = 256;

  Column(this.name, this.type, {this.size = 256});

}

class Row {

  Map _values = {};
  String table = "";
  var db = Model.db;

  Row(this.table, this._values);

  dynamic getValue(String name)
  {
    return _values[name];
  }

  void delete()
  {
    var id = _values["id"];
    String query = "DELETE FROM $table WHERE id = $id;";

    db.execute(query);

  }

  void update(Map data)
  {
    String query = "UPDATE $table SET ";
    data.forEach((key, value) {
      if (_values.keys.contains(key)){
        query += "$key = $value";
        _values[key] = value;
      }else {
        throw Exception("$key doesn't exist");
      }
    });
    var id = _values["id"];
    query += "WHERE id = $id;";
    db.execute(query);
  }

  toMap(){
    return this._values;
  }


}


class Model
{
  
  List<Column> fields = [];
  List<String> rows = [];
  String name = "";
  static var db = setup_database();

  Model(this.name, this.fields){
    fields.forEach((element) {
      rows.add(element.name);
    });
  }

  String compile()
  {

    String query ='CREATE TABLE $name ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,';

    for (var item in fields)
    {
      String name = item.name;
      String type = item.type.key;
      int size = item.size;
      query += '$name $type($size), ';
    }

    query = query.substring(0, query.length - 2);
    query = "$query);";
    

    return query;


  }


  void migrate({force = false}) async
  {
    final String query = compile();
    try {
       db.execute(query);
    }
    on Exception {
      if (force) {
        db.execute('DROP TABLE $name;');
        db.execute(query);
      }
    }
   
  }

  List getAll()
  {
    List<Row> rows = [];
    final String query = "SELECT * FROM $name";
    try {
      final ResultSet result = db.select(query);
      result.toList().forEach((element) {
        rows.add(Row(name, element));
      });
      return rows;
    } on Exception {
      throw Exception("Table not created, please migrate and run");
    }

  }

  void insert(Map values)
  {

    values.forEach((key, value) {
      if (!rows.contains(key)){
        throw Exception('Column $key in $name Doesn\'t Exist');
      }
    });

    String query = 'INSERT INTO $name(';

    for (var name in values.keys)
    {
      query += '$name, ';
    }

    query = query.substring(0, query.length - 2);
    query = "$query) VALUES (";

    for (var value in values.values)
    {
      query += '"$value", ';
    }

    query = query.substring(0, query.length - 2);
    query = "$query);";

    try {
      db.execute(query);
    } on Exception {
      throw Exception("Table not created, please migrate and run");
    }

    
  }

  Row getOne(int id)
  {
    String query = "SELECT * FROM $name WHERE id = $id LIMIT 1;";
    try {
      var list = db.select(query).toList();
      return list.length != 0 ? Row(name, list[0]) : Row("", {});
    } on Exception {
      throw Exception("Table not created, please migrate and run");
    }


  }

}

