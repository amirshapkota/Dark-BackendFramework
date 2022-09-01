import 'package:dark/request.dart';
import 'models.dart';

List get_all_users(Request request)
{
  return user.getAll();
}

Map seed_data(Request request)
{

  user.insert({
    "name": "apurba",
    "age": 18,
  });

  return {"sucess" : "true"};
}

Map delete_user(Request request)
{
  var first_user  = user.getAll()[0];
  first_user.delete();
  return {"success" : "true"};
}

