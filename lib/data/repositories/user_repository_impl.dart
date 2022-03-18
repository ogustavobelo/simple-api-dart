import 'package:injectable/injectable.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required UsersLocalDataSource localDataSource})
      : _localDataSource = localDataSource;
  final UsersLocalDataSource _localDataSource;

  @override
  Future<Serializable> listAllUsers() async {
    final users = await _localDataSource.listUsers();
    return users.serialize();
  }

  @override
  Future<Serializable> saveUser(String name, String email) async {
    final user = User.simple(name: name, email: email);
    final result = await _localDataSource.saveUser(user);
    return result.serialize();
  }
}
