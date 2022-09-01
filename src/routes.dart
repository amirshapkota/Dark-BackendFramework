import 'package:main/route.dart';
import "./controls.dart" as controls;

void create_routes() {

  Route.get("/users", controls.get_all_users);
  Route.get('/seed', controls.seed_data);
}