import 'dart:convert';
import 'dart:io';

import 'package:dark/request.dart';

class Route
{

  static List<Route> routes = [];
  static List<String> route_names = [];

  String path = "";
  String method = "";
  Function callback = (request){ 
    return {};
  };


  Route(this.path, this.callback, this.method)
  {
    route_names.add(this.path);
    routes.add(this);
  }

  static void get(String path, Function(Request) callback)
  {
    Route(path, callback, "GET");
  }

  static void post(String path, Function(Request) callback)
  {
    Route(path, callback, "POST");
  }

  void callbackFunc(HttpRequest request)
  {
    var data = callback(Request(request));
    request.response.headers.set("Content-type", "application/json");
    if (data is List){
      var res = [];
      data.forEach((val) => res.add(val.toMap()));
      data = res;
    }
    request.response.write(jsonEncode(data));
  }


}