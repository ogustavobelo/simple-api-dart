// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../controllers/users/users_routes.dart' as _i13;
import '../../data/datasources/local/database/acess_database.dart' as _i8;
import '../../data/datasources/local/users/users_local_datasource.dart' as _i7;
import '../../data/helpers/users_helper.dart' as _i6;
import '../../data/repositories/user_repository_impl.dart' as _i10;
import '../../domain/repositories/user_repository.dart' as _i9;
import '../../domain/usecases/list_users_usecase.dart' as _i11;
import '../../domain/usecases/save_user_usecase.dart' as _i12;
import '../enviroment.dart' as _i5;
import '../middlewares/auth_middleware.dart' as _i3;
import '../server/server.dart' as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthMiddleware>(() => _i3.AuthMiddleware());
  gh.singleton<_i4.Server>(_i4.Server(
      auth: get<_i3.AuthMiddleware>(), environment: get<_i5.Environment>()));
  gh.factory<_i6.UsersHelper>(() => _i6.UsersHelperImpl());
  gh.factory<_i7.UsersLocalDataSource>(
      () => _i7.UsersLocalDataSourceImpl(database: get<_i8.AccessDatabase>()));
  gh.factory<_i9.UserRepository>(() => _i10.UserRepositoryImpl(
      localDataSource: get<_i7.UsersLocalDataSource>(),
      helper: get<_i6.UsersHelper>()));
  gh.factory<_i11.ListUserUseCase>(
      () => _i11.ListUserUseCase(repository: get<_i9.UserRepository>()));
  gh.factory<_i12.SaveUserUseCase>(
      () => _i12.SaveUserUseCase(repository: get<_i9.UserRepository>()));
  gh.factory<_i13.UsersPrivateController>(() => _i13.UsersPrivateController(
      listUserUseCase: get<_i11.ListUserUseCase>(),
      saveUserUseCase: get<_i12.SaveUserUseCase>()));
  gh.factory<_i13.UsersPublicController>(() =>
      _i13.UsersPublicController(saveUserUseCase: get<_i12.SaveUserUseCase>()));
  gh.singleton<_i13.UsersController>(_i13.UsersController(
      privateController: get<_i13.UsersPrivateController>(),
      publicController: get<_i13.UsersPublicController>()));
  return get;
}
