import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/base/base_controller.dart';
import 'package:simple_crud/core/middlewares/auth_middleware.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/domain/usecases/list_users_usecase.dart';
import 'package:simple_crud/domain/usecases/save_user_usecase.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';

part 'users_routes.g.dart';

@singleton
class UsersController {
  UsersController({
    required UsersPrivateController privateController,
    required UsersPublicController publicController,
  })  : _privateController = privateController,
        _publicController = publicController;
  final UsersPrivateController _privateController;
  final UsersPublicController _publicController;

  Handler get router => Cascade()
      .add(_publicController.routes)
      .add(_privateController.routes)
      .handler;
}

@injectable
class UsersPrivateController extends BaseController {
  UsersPrivateController({
    required ListUserUseCase listUserUseCase,
    required SaveUserUseCase saveUserUseCase,
  }) : _listUsersUC = listUserUseCase;
  final ListUserUseCase _listUsersUC;

  @Route.get("/")
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

  @Route.get("/renew_token/<id>")
  Response _generateToken(Request request, String? id) {
    if (id == null) return error("User uid is required");
    final token = JwtAuthUtils.auth(id);
    return success(object: Serializable({"token": token}));
  }

  Handler get routes => Pipeline()
      .addMiddleware(AuthMiddleware().jwt())
      .addHandler(_$UsersPrivateControllerRouter(this));
}

@injectable
class UsersPublicController extends BaseController {
  UsersPublicController({
    required SaveUserUseCase saveUserUseCase,
  }) : _saveUserUC = saveUserUseCase;
  final SaveUserUseCase _saveUserUC;

  @Route.post('/')
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

  Router get routes => _$UsersPublicControllerRouter(this);
}
