import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:simple_crud/controllers/generic/generic_routes.dart';
import 'package:simple_crud/controllers/users/users_routes.dart';
import 'package:simple_crud/core/dependecy_injection/getit.dart';
import 'package:simple_crud/core/enviroment.dart';

void main(List<String> args) async {
  final host = Platform.environment['HOST'] ?? '0.0.0.0';
  final dbHost = Platform.environment['DATABASE_HOST'] ?? '0.0.0.0';
  final serverPort = int.parse(Platform.environment['SERVER_PORT'] ?? '3000');
  final dbPort = int.parse(Platform.environment['DATABASE_PORT'] ?? '27017');
  final environment = Environment(serverPort: serverPort, dbPort: dbPort, dbHost: dbHost, host: host);
  await configureDependencies(environment);

  final _router = Cascade().add(getIt<UsersController>().router).add(GenericController().router).handler;
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final server = await serve(_handler, host, serverPort);
  print('Server listening on port ${server.address.host}:${server.port}');
}
