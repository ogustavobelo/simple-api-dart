import 'dart:io';

import 'package:injectable/injectable.dart' hide Environment;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/generic/generic_routes.dart';
import 'package:simple_crud/controllers/users/users_routes.dart';
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/middlewares/auth_middleware.dart';

@singleton
class Server {
  final AuthMiddleware auth;
  final Environment environment;
  Server({
    required this.auth,
    required this.environment,
  });

  Future<HttpServer> start() async {
    final _router = Router();
    _router.mount("/users/", getIt<UsersController>().router);
    _router.mount("/", GenericController().router);

    final _handler =
        Pipeline().addMiddleware(logRequests()).addHandler(_router);

    return serve(_handler, environment.host, environment.serverPort);
  }
}
