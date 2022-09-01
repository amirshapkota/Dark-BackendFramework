import 'package:main/route.dart';
import "./controls.dart";

void create_routes() {

  Route.get("/users", get_all_users);
  Route.get('/seed', seed_data);
}