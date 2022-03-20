import 'package:injectable/injectable.dart';
import 'package:simple_crud/domain/exceptions/local_datasource_exceptions.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';
import 'package:simple_crud/data/datasources/local/database/collections.dart';
import 'package:simple_crud/data/models/user/user_model.dart';

abstract class UsersLocalDataSource {
  Future<UserCollection> listUsers();
  Future<UserModel> saveUser(UserModel user);
}

@Injectable(as: UsersLocalDataSource)
class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  const UsersLocalDataSourceImpl({required AccessDatabase database}) : _database = database;
  final AccessDatabase _database;

  @override
  Future<UserCollection> listUsers() async {
    try {
      final usersMap = await _database.listAll(Collections.users);
      final parsedUsers = usersMap.map<UserModel>((e) => UserModel.fromJson(e)).toList();
      return UserCollection(parsedUsers);
    } catch (e) {
      throw LocalDataSourceException(message: "Cannot list users");
    }
  }

  @override
  Future<UserModel> saveUser(UserModel user) async {
    try {
      final savedUser = await _database.save(Collections.users, user.toJson());
      return UserModel.fromJson(savedUser);
    } catch (e) {
      throw LocalDataSourceException(message: "Cannot save user ${user.email}");
    }
  }
}
