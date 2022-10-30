import 'package:dark/route.dart';
import "./controls.dart" as controls;

void create_routes() {

  Route.get("/users", controls.get_all_users);
  Route.get("/user/delete", controls.delete_user);
  Route.get('/seed', controls.seed_data);
  
}