import 'package:dark/model.dart';

final Model user = Model("users", [
  Column("name", DataType.VARCHAR),
  Column("age", DataType.INTEGER)
]);

final List<Model> models = [
  user
];
