import 'package:simple_crud/domain/models/user/user_model.dart';

abstract class UserRepository {
  Future<UserCollection> listAllUsers();
  Future<User> saveUser(User user);
}