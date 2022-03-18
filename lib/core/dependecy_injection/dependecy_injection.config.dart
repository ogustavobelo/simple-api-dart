// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../controllers/users/users_routes.dart' as _i9;
import '../../data/datasources/local/database/acess_database.dart' as _i4;
import '../../data/datasources/local/users/users_local_datasource.dart' as _i3;
import '../../data/repositories/user_repository_impl.dart' as _i6;
import '../../domain/repositories/user_repository.dart' as _i5;
import '../../domain/usecases/list_users_usecase.dart' as _i7;
import '../../domain/usecases/save_user_usecase.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.UsersLocalDataSource>(
      () => _i3.UsersLocalDataSourceImpl(database: get<_i4.AccessDatabase>()));
  gh.factory<_i5.UserRepository>(() =>
      _i6.UserRepositoryImpl(localDataSource: get<_i3.UsersLocalDataSource>()));
  gh.factory<_i7.ListUserUseCase>(
      () => _i7.ListUserUseCase(repository: get<_i5.UserRepository>()));
  gh.factory<_i8.SaveUserUseCase>(
      () => _i8.SaveUserUseCase(repository: get<_i5.UserRepository>()));
  gh.singleton<_i9.UsersController>(_i9.UsersController(
      listUserUseCase: get<_i7.ListUserUseCase>(),
      saveUserUseCase: get<_i8.SaveUserUseCase>()));
  return get;
}
