import 'package:simple_crud/data/datasources/local/database/acess_database.dart';

class DevDatabase implements AccessDatabase {
  List<Map<String, dynamic>> localUsers = [];

  @override
  Future<List<Map<String, dynamic>>> listAll(String collection) async {
    return localUsers;
  }

  @override
  Future<Map<String, dynamic>> save(
      String collection, Map<String, dynamic> object) async {
    localUsers.add(object);
    return object;
  }
}
