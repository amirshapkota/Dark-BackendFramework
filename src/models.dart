import 'package:dark/model.dart';

final Model user = Model("users", [
  Column("name", DataType.VARCHAR),
  Column("age", DataType.INTEGER)
]);

final Model book = Model("books", [
  Column("name", DataType.INTEGER),
  Column("pages", DataType.INTEGER)
]);

final List<Model> models = [
  user
];
