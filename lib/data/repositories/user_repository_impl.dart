import 'package:injectable/injectable.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/helpers/users_helper.dart';
import 'package:simple_crud/data/models/mappers/user_serialize_mapper.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required UsersLocalDataSource localDataSource,
    required UsersHelper helper,
  })  : _localDataSource = localDataSource,
        _helper = helper;
  final UsersLocalDataSource _localDataSource;
  final UsersHelper _helper;

  @override
  Future<Serializable> listAllUsers() async {
    final users = await _localDataSource.listUsers();
    return users.serialize();
  }

  @override
  Future<Serializable> saveUser(String name, String email) async {
    final user = _helper.buildUser(name, email);
    final result = await _localDataSource.saveUser(user);
    return result.serialize();
  }
}
