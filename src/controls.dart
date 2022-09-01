import 'dart:io';
import 'models.dart';

List get_all_users(HttpRequest request)
{
  return user.getAll();
}

Map seed_data(HttpRequest request)
{

  user.insert({
    "name": "apurba",
    "age": 18,
    "phone": "9841212827"
  });

  return {"sucess" : "true"};
}

