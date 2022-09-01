import 'dart:io';

import 'package:main/route.dart';
import "../src/routes.dart";

void main(List<String> args) async {

  create_routes();

  var server = await HttpServer.bind(InternetAddress.anyIPv6, 8000);

  print("[ Server ] Running at port 8000");

  await server.forEach((HttpRequest request) {
    var method = request.method;
    var ip = request.requestedUri;
    
    if ( Route.route_names.contains(request.uri.toString()) )
    {
      var route = Route.routes[Route.route_names.indexOf(request.uri.toString())];

      if (route.method == request.method)
      {
        route.callbackFunc(request);
      }else {
        request.response.statusCode = 405;
        request.response.write("405 METHOD NOT ALLOWED");
      }
      
    }else {
      request.response.statusCode = 404;
      request.response.write("404 NOT FOUND");
    }

    print('[ Server ] $method $ip');



    request.response.close();
  });

}