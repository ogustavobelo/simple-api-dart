// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../controllers/response_utils.dart' as _i3;
import '../../controllers/users/users_routes.dart' as _i10;
import '../../data/datasources/local/database/acess_database.dart' as _i5;
import '../../data/datasources/local/users/users_local_datasource.dart' as _i4;
import '../../data/repositories/user_repository_impl.dart' as _i7;
import '../../domain/repositories/user_repository.dart' as _i6;
import '../../domain/usecases/list_users_usecase.dart' as _i8;
import '../../domain/usecases/save_user_usecase.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ResponseUtils>(() => _i3.ResponseUtils());
  gh.factory<_i4.UsersLocalDataSource>(
      () => _i4.UsersLocalDataSourceImpl(database: get<_i5.AccessDatabase>()));
  gh.factory<_i6.UserRepository>(() =>
      _i7.UserRepositoryImpl(localDataSource: get<_i4.UsersLocalDataSource>()));
  gh.factory<_i8.ListUserUseCase>(
      () => _i8.ListUserUseCase(repository: get<_i6.UserRepository>()));
  gh.factory<_i9.SaveUserUseCase>(
      () => _i9.SaveUserUseCase(repository: get<_i6.UserRepository>()));
  gh.singleton<_i10.UsersController>(_i10.UsersController(
      listUserUseCase: get<_i8.ListUserUseCase>(),
      saveUserUseCase: get<_i9.SaveUserUseCase>(),
      utils: get<_i3.ResponseUtils>()));
  return get;
}
