import 'dart:convert';
import 'dart:io';

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

  static void get(String path, Function(HttpRequest) callback)
  {
    Route(path, callback, "GET");
  }

  static void post(String path, Function(HttpRequest) callback)
  {
    Route(path, callback, "POST");
  }

  void callbackFunc(HttpRequest request)
  {
    var data = callback(request);
    request.response.headers.set("Content-type", "application/json");
    request.response.write(jsonEncode(data));
  }


}