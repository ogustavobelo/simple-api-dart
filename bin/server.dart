import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:simple_crud/controllers/generic/generic_routes.dart';
import 'package:simple_crud/controllers/users/users_routes.dart';
import 'package:simple_crud/core/dependecy_injection/getit.dart';
import 'package:simple_crud/core/enviroment.dart';

void main(List<String> args) async {
  final environment = EnvironmentBuild();
  await configureDependencies(environment);

  final _router = Cascade()
      .add(getIt<UsersController>().router)
      .add(GenericController().router)
      .handler;
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final server =
      await serve(_handler, environment.host, environment.serverPort);
  print('Server listening on port ${server.address.host}:${server.port}');
}
