import 'package:simple_crud/domain/entities/serializable/serializable.dart';

abstract class UserRepository {
  Future<Serializable> listAllUsers();
  Future<Serializable> saveUser(String name, String email);
}