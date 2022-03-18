import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/response_utils.dart';
import 'package:simple_crud/domain/models/user/user_model.dart';
import 'package:simple_crud/domain/usecases/list_users_usecase.dart';
import 'package:simple_crud/domain/usecases/save_user_usecase.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';

part 'users_routes.g.dart';

@singleton
class UsersController {
  UsersController({
    required ListUserUseCase listUserUseCase,
    required SaveUserUseCase saveUserUseCase,
    required ResponseUtils utils,
  })  : _listUsersUC = listUserUseCase,
        _saveUserUC = saveUserUseCase,
        _utils = utils;
  final ResponseUtils _utils;
  final ListUserUseCase _listUsersUC;
  final SaveUserUseCase _saveUserUC;

  @Route.get('/users')
  Future<Response> listUsers(Request request) async {
    try {
      final authorization = request.headers["authorization"];
      if (authorization == null) return Response.forbidden("Token not found");
      final users = await _listUsersUC();
      return _utils.success(
          aJson: users.toJson(), message: "${users.users.length} user listed");
    } catch (e, st) {
      return _utils.error("Cannot fetch Users", error: e, stackTrace: st);
    }
  }

  @Route.get('/users/<id>')
  Response _listUser(Request request) {
    final id = request.params['id'];
    final authorization = request.headers["authorization"];
    return Response.ok('$id\n');
  }

  @Route.put('/users/<id>')
  Response _updateUser(Request request) {
    final id = request.params['id'];
    return Response.ok('$id\n');
  }

  @Route.delete('/users/<id>')
  Response _deleteUser(Request request) {
    final id = request.params['id'];
    return Response.ok('$id\n');
  }

  @Route.post('/users')
  Future<Response> _createUser(Request request) async {
    try {
      final json = jsonDecode(await request.readAsString());
      final email = json["email"] as String?;
      final name = json["name"] as String?;

      if (email.isEmptyOrNull || name.isEmptyOrNull) {
        return _utils.error("Name and Email is required");
      }

      final user = User.simple(name: name!, email: email!);
      final savedUser = await _saveUserUC(user);
      return _utils.success(
        message: 'User ${user.name} created successfully!\n',
        aJson: savedUser.toJson(),
      );
    } catch (e, st) {
      return _utils.error("Cannot save User", error: e, stackTrace: st);
    }
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  Router get router => _$UsersControllerRouter(this);
}
