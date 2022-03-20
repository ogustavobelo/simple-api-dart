import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/logger/logger.dart';
import 'package:simple_crud/core/server/server.dart';

void main(_) async {
  final environment = EnvironmentBuild();
  await dependenciesSetup(environment);

  final server = await getIt<Server>().start();
  getIt<Logger>()
      .info('Server listening on port ${server.address.host}:${server.port}');
}
