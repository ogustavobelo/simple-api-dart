import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:mongo_dart/mongo_dart.dart';

import 'package:simple_crud/core/dependecy_injection/getit.config.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies(Environment env, Db database) {
  getIt.registerSingleton<Environment>(env);
  getIt.registerFactory<AccessDatabase>(() => AccessDatabaseImpl(database));
  $initGetIt(getIt);
}
