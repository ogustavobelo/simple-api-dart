import 'package:mongo_dart/mongo_dart.dart';

abstract class AccessDatabase {
  Future<List<Map<String, dynamic>>> listAll(String collection);
  Future<void> save(String collection, Map<String, dynamic> object);
}

class AccessDatabaseImpl implements AccessDatabase {
  AccessDatabaseImpl(this.instance);
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
  Future<void> save(String collection, Map<String, dynamic> object) async{
    try {
      await instance.collection(collection).insert(object);
    } catch (_) {
      rethrow;
    }
  }
}
