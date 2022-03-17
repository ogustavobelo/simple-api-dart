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
Future<void> configureDependencies(Environment env) async {
  getIt.registerSingleton<Environment>(env);
  final database = await createDB(env.dbHost, env.dbPort);
  getIt.registerFactory<AccessDatabase>(() => AccessDatabaseImpl(database));
  $initGetIt(getIt);
}

Future<Db> createDB(String dbHost, int dbPort) async {
  final dbPath = "mongodb://$dbHost:$dbPort/crud";
  print("Starting db on path $dbPath at ${DateTime.now().toIso8601String()}...");
  final db = await Db.create(dbPath);
  await db.open();
  print("Database inited successfully!");
  return db;
}
