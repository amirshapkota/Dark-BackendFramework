import 'package:sqlite3/sqlite3.dart';

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


class Model
{
  
  List<Column> fields = [];
  List<String> rows = [];
  String name = "";
  static var db = sqlite3.open("database.db");

  Model(this.name, this.fields){
    fields.forEach((element) {
      rows.add(element.name);
    });
  }

  String compile()
  {

    String query ='CREATE TABLE $name (';

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


  void migrate({force = false}) 
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
    final String query = "SELECT * FROM $name";
    try {
      final ResultSet result = db.select(query);
      return result.toList();
    } on Exception {
      throw Exception("Table not created, please migrate and run");
    }

  }

  void insert(Map values)
  {

    values.forEach((key, value) {
      if (!rows.contains(key)){
        throw Exception('Column in $name Doesn\'t Exist');
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

  Map getOne(int id)
  {
    String query = "SELECT * FROM $name WHERE id = $id LIMIT 1;";
    try {
      var list = db.select(query).toList();
      return list.length != 0 ? list[0] : {};
    } on Exception {
      throw Exception("Table not created, please migrate and run");
    }


  }

}
