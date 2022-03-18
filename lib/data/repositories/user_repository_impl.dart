import 'package:injectable/injectable.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required UsersLocalDataSource localDataSource}) : _localDataSource = localDataSource;
  final UsersLocalDataSource _localDataSource;

  @override
  Future<UserCollection> listAllUsers() async {
    return _localDataSource.listUsers();
  }

  @override
  Future<User> saveUser(User user) {
    return _localDataSource.saveUser(user);
  }
}
