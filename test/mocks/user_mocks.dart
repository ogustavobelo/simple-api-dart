import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/helpers/users_helper.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUsersHelper extends Mock implements UsersHelper {}

class MockUsersLocalDataSource extends Mock implements UsersLocalDataSource {}
