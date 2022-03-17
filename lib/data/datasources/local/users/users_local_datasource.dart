import 'package:injectable/injectable.dart';
import 'package:simple_crud/core/exceptions/local_datasource_exceptions.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';
import 'package:simple_crud/data/datasources/local/database/collections.dart';
import 'package:simple_crud/data/models/user/user_model.dart';

abstract class UsersLocalDataSource {
  Future<UserCollection> listUsers();
  Future<void> saveUser(User user);
}

@Injectable(as: UsersLocalDataSource)
class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  const UsersLocalDataSourceImpl({required AccessDatabase database}) : _database = database;
  final AccessDatabase _database;

  @override
  Future<UserCollection> listUsers() async {
    try {
      final usersMap = await _database.listAll(Collections.users);
      final parsedUsers = usersMap.map<User>((e) => User.fromJson(e)).toList();
      return UserCollection(parsedUsers);
    } catch (e) {
      throw LocalDataSourceException(message: "Cannot list users");
    }
  }

  @override
  Future<void> saveUser(User user) async {
    try {
      await _database.save(Collections.users, user.toJson());
    } catch (e) {
      throw LocalDataSourceException(message: "Cannot save user ${user.email}");
    }
  }
}
