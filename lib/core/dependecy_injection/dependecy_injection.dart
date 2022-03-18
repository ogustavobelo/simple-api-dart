import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.config.dart';

import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/logger/logger.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';
import 'package:simple_crud/data/datasources/local/database/dev_database.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> dependenciesSetup(Environment env) async {
  getIt.registerSingleton<Environment>(env);
  getIt.registerSingleton<Logger>(LoggerImpl.create());
  final accessDatabase =
      env.isProd ? await AccessDatabaseImpl.create() : DevDatabase();

  getIt.registerFactory<AccessDatabase>(() => accessDatabase);
  $initGetIt(getIt);
}
