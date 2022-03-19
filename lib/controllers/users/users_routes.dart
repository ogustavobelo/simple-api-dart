import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/base/base_controller.dart';
import 'package:simple_crud/domain/usecases/list_users_usecase.dart';
import 'package:simple_crud/domain/usecases/save_user_usecase.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';

part 'users_routes.g.dart';

@singleton
class UsersController extends BaseController {
  UsersController({
    required ListUserUseCase listUserUseCase,
    required SaveUserUseCase saveUserUseCase,
  })  : _listUsersUC = listUserUseCase,
        _saveUserUC = saveUserUseCase;
  final ListUserUseCase _listUsersUC;
  final SaveUserUseCase _saveUserUC;

  @Route.get('/users')
  Future<Response> listUsers(Request request) async {
    try {
      final authorization = request.headers["authorization"];
      if (authorization == null) return Response.forbidden("Token not found");
      final users = await _listUsersUC();
      return success(object: users, log: "${users.json.length} user listed");
    } catch (e, st) {
      return error("Cannot fetch Users", error: e, stackTrace: st);
    }
  }

  @Route.get('/users/<id>')
  Response _listUser(Request request) {
    final id = request.params['id'];
    // final authorization = request.headers["authorization"];
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
        return error("Name and Email is required");
      }

      final savedUser = await _saveUserUC(name!, email!);
      return success(
        object: savedUser,
        log: 'User $name created successfully!\n',
      );
    } catch (e, st) {
      return error("Cannot save User", error: e, stackTrace: st);
    }
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  Router get router => _$UsersControllerRouter(this);
}
