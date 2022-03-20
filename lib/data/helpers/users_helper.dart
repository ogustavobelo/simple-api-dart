import 'package:injectable/injectable.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';
import 'package:simple_crud/core/middlewares/auth_middleware.dart';
import 'package:simple_crud/data/models/user/user_model.dart';

abstract class UsersHelper {
  UserModel buildUser(String name, String email);
}

@Injectable(as: UsersHelper)
class UsersHelperImpl implements UsersHelper {
  @override
  UserModel buildUser(String name, String email) {
    final uid = StringUtils.uuid();
    final token = JwtAuthUtils.auth(uid);
    return UserModel(
      uid: uid,
      token: token,
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
  }
}
