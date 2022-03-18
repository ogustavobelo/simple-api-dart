import 'package:mongo_dart/mongo_dart.dart';
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/logger/logger.dart';

abstract class AccessDatabase {
  Future<List<Map<String, dynamic>>> listAll(String collection);
  Future<void> save(String collection, Map<String, dynamic> object);
}

class AccessDatabaseImpl implements AccessDatabase {
  AccessDatabaseImpl._(this.instance);
  final Db instance;

  @override
  Future<List<Map<String, dynamic>>> listAll(String collection) async {
    try {
      final result = await instance.collection(collection).find().toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> save(String collection, Map<String, dynamic> object) async {
    try {
      await instance.collection(collection).insert(object);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AccessDatabaseImpl> create() async {
    final env = getIt<Environment>();
    final logger = getIt<Logger>();

    final dbPath = "mongodb://${env.dbHost}:${env.dbPort}/crud";
    try {
      logger.info(
          "Starting db on path $dbPath at ${DateTime.now().toIso8601String()}...");
      final db = await Db.create(dbPath);
      await db.open();
      logger.info("Database inited successfully!");
      return AccessDatabaseImpl._(db);
    } catch (e, st) {
      logger.debug("Cannot open database", e, st);
      rethrow;
    }
  }
}
