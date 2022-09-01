import 'package:main/model.dart';

final Model user = Model("users", [
  Column("name", DataType.VARCHAR),
  Column("age", DataType.INTEGER),
  Column("phone", DataType.VARCHAR)
]);

final Model book = Model("books", [
  Column("name", DataType.VARCHAR),
  Column("pages", DataType.VARCHAR),
  Column("author_name", DataType.VARCHAR)
]);


final List<Model> models = [
  user,
  book
];
